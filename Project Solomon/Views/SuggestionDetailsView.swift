//
//  SuggestionDetailsView.swift
//  Project Solomon
//
//  Created by Cole Hardy on 4/28/23.
//

import SwiftUI

struct SuggestionDetailsView: View {
    //@State var stock:Ticker
    
    @State var details:AlgReturn
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Suggestion Details")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(details.code + " - " + details.alg)
                    .font(.caption)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(details.code).font(.title).bold()
                    Spacer()
                    Text("$\(details.profit)")
                    if details.percentReturn >= 0 {
                        Text("+\(details.percentReturn)%").foregroundColor(.green)
                    }
                    else {
                        Text("-\(details.percentReturn)%").foregroundColor(.red)
                    }
                }
                HStack {
                    Text(details.alg)
                    Spacer()
                }
                
                Image("graph").resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                
                List {
                    ForEach(details.trades) {trade in
                        if trade.action == "Buy" {
                            HStack {
                                Text("Buy @ $\(trade.price)")
                            }
                        }
                        
                        else {
                            HStack {
                                Text("Sell @ $\(trade.price)")
                                Spacer()
                                Text("+$\(trade.profit)").foregroundColor(.green)
                            }
                        }
                    }
                    HStack {
                        Text("Trade 1")
                        Text("- Buy @ $31.15")
                    }
                    HStack {
                        Text("Trade 2")
                        Text("- Sell @ $31.15")
                        Spacer()
                        Text("+$3.15").foregroundColor(.green)
                    }
                    HStack {
                        Text("Trade 3")
                        Text("- Sell @ $31.15")
                        Spacer()
                        Text("-$3.15").foregroundColor(.red)
                        
                    }
                    HStack {
                        Text("Trade 4")
                        Text("- Buy @ $31.15")
                        
                    }
                }
                
                
                
            }
            .padding()
            .background(Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 15))
            .padding()
            
            

        }
        
    }
    
}

struct SuggestionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionDetailsView(details: AlgReturn(profit: 0, percentReturn: 0, trades: [], code: "RIVN", alg: "Mean Reversion", prices: [], suggestion: "Hold"))
    }
}
