//
//  MR Functions.swift
//  Project Solomon
//
//  Created by Cole Hardy on 4/28/23.
//

import Foundation

//Structures for the ouput
struct Trade: Identifiable {
    var id:UUID = UUID()
    var action:String
    var price:Float
    var profit:Float
    var day:Int
    var warning:String
    
}
struct AlgReturn {
    var profit:Float
    var percentReturn:Float
    var trades:[Trade]
    var code:String
    var alg:String
    var prices:[Float]
    var suggestion:String
    
    
    mutating func loadProfit() {
        var profit:Float = 0
        for trade in self.trades {
            if trade.action == "Sell" {
                profit += trade.profit
            }
        }
       self.profit = profit
    }
    
    mutating func loadReturn() {
        var buys:Int = 0
        var firstBuy:Float = 0
        
        if trades.count > 0 {
            firstBuy = trades[0].price
        }
        
        else {
            firstBuy = 0
        }
        
        for trade in trades {
            if trade.action == "Buy" {
                buys += 1
            }
        }




        if buys != 0 {
            self.percentReturn = (self.profit / firstBuy) * 100
        }
        else {
            self.percentReturn = 10.00
        }

    }
    
    
    mutating func loadSuggestion() {
        if self.trades.count != 0 {
            let temp = self.trades.last
            if temp!.day == 99 {
                self.suggestion = temp!.action
            }
            else {
                self.suggestion = "Hold"
            }
        }
        
        else {
            self.suggestion = "Hold"
        }
        
    }
    
    
    mutating func loadAll() {
        self.loadProfit()
        self.loadReturn()
        self.loadSuggestion()
    }
    
    init(profit: Float, percentReturn: Float, trades: [Trade], code: String, alg: String, prices: [Float], suggestion: String) {
        self.profit = profit
        self.percentReturn = percentReturn
        self.trades = trades
        self.code = code
        self.alg = alg
        self.prices = prices
        self.suggestion = suggestion
        
        
        
        
        
        
        
        //TEST TEST TEST
        
        
        
        
        
        
        self.loadAll()
    }

}

//Structures if needed for the return of the API

struct Welcome: Codable {
    let metaData: MetaData
    let timeSeriesDaily: [String: TimeSeriesDaily]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDaily = "Time Series (Daily)"
    }
}

// MARK: - MetaData
struct MetaData: Codable {
    let the1Information, the2Symbol, the3LastRefreshed, the4OutputSize: String
    let the5TimeZone: String

    enum CodingKeys: String, CodingKey {
        case the1Information = "1. Information"
        case the2Symbol = "2. Symbol"
        case the3LastRefreshed = "3. Last Refreshed"
        case the4OutputSize = "4. Output Size"
        case the5TimeZone = "5. Time Zone"
    }
}

// MARK: - TimeSeriesDaily
struct TimeSeriesDaily: Codable {
    let the1Open, the2High, the3Low, the4Close: String
    let the5AdjustedClose, the6Volume, the7DividendAmount, the8SplitCoefficient: String

    enum CodingKeys: String, CodingKey {
        case the1Open = "1. open"
        case the2High = "2. high"
        case the3Low = "3. low"
        case the4Close = "4. close"
        case the5AdjustedClose = "5. adjusted close"
        case the6Volume = "6. volume"
        case the7DividendAmount = "7. dividend amount"
        case the8SplitCoefficient = "8. split coefficient"
    }
}



func MR(code:String) -> AlgReturn {
    // Creates the algReturn object and sets up zeros for the alg
    var algReturn:AlgReturn = AlgReturn(profit: 0, percentReturn: 0, trades: [], code: "", alg: "Mean Reversion", prices:[], suggestion: "")
    var urlTEST:String = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=RIVN&apikey=JJI3NVB2R98E5ILV"
    
    var prices:[Float] = []
    
    let url = URL(string:urlTEST)
    
    var request = URLRequest(url:url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
    
    request.httpMethod = "GET"
    
    let session = URLSession.shared
    
    let dataTask = session.dataTask(with: request) { (data, response, error) in
        // Check for errors
        if error == nil && data != nil {
            
            // Try parsing the data
            do {
                let stockDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
                let decoder = JSONDecoder()
                
                // Converts the raw JSON into the struct format so that it can be used now :)))
                let feed = try decoder.decode(Welcome.self, from: data!)
                
                for day in feed.timeSeriesDaily.values {
                    
                    
                    prices.append(Float(day.the4Close)!)
                    
                }
                
                algReturn.prices = prices
                algReturn.code = code
                //print("AFTER ASSIGNMENT")
                //print(algReturn)
                
                
            }
            catch {
                print("ERROR PARSING DATA")
            }
            
        }
        
        //print("JUST BEFORE LET BREAK")
        //print(algReturn)
        
        
    }
    
    //Fire off data task
    dataTask.resume()
    
    
    
    
    
    algReturn.code = code // Stores the code for the alg
    
    sleep(1) // WAITS FOR THE PRICES TO BE LOADED
    
    algReturn.prices.reverse() // Re orients the list of prices so that

    // Mean Reversion math just like in the python script

    //Variable Initializations/Declarations
    var day:Int = 0 // Sets the day to 0
    var avg_price:Float
    let tolerence:[Float] = [0.95, 1.05] // Sets the tolerences
    var buy:Float = 0
    var buys:Int = 0 // Records how many buys have occured so a divide by 0 error doesnt occur

    for current_price in algReturn.prices {

        if day >= 5 {
            avg_price = ((algReturn.prices[day - 5...day]).reduce(0, +) / 5) // GOOFY MEAN CALCULATION THAT COULD BE WRONG

            if current_price < avg_price * tolerence[0] { // Checks if the current price is below the 95% threshold. If so it moves to the buy code

                //BUY CODE
                if buy == 0 {
                    // ROUND CURRENT PRICE SOMEHOW LMAO

                    buy = current_price // "BUYS" The stock

                    //RECORDS THE TRADE
                    algReturn.trades.append(Trade(action: "Buy", price: buy, profit: 0, day: day, warning: ""))

                    buys += 1
    
                }
            }

            // CHECKS IF CURRENT PRICE IS OVER THE 105% Threshold
            else if current_price > avg_price * tolerence[1] {
                // Makes sure a buy has occured before it tries to sell
                if buy != 0 {
                    // Records the sale action
                    algReturn.trades.append(Trade(action: "Sell", price: current_price, profit: current_price - buy, day: day, warning:""))

                    // Records the day that the sale occured

                    buy = 0 // Resets the buy because you sold
                }
            }
            //STOP LOSS
            else if current_price <= buy * 0.93 {
                algReturn.trades.append(Trade(action: "Sell", price: current_price, profit: current_price - buy, day: day, warning: "Stop Loss"))
                // Records the day the sale occured

                // Reset the buy variable
                buy = 0
            }
        }
        day += 1 // The sun rising on a greatful universe
    }
    
    return algReturn
}


