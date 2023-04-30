//
//  StockData.swift
//  Project Solomon
//
//  Created by Cole Hardy on 4/28/23.
//

import Foundation

struct StockData {
    
    var code:String
    var fullName:String
    var alg:String
    var percentReturns = 12.36
    var totalReturn = 0.00
    var marketDifference = 0.00
    
    
    init(code: String, fullName: String, alg: String) {
        self.code = code
        self.fullName = fullName
        self.alg = alg
        
        self.percentReturns = round(self.percentReturns * 100) / 100.0
    }
    
    
    func loadData() {
        // Calls API and loads the data into the stock structure
    }
}
