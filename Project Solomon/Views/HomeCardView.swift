//
//  HomeCardView.swift
//  Project Solomon
//
//  Created by Cole Hardy on 4/29/23.
//

import SwiftUI

struct HomeCardView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    var currentTicker:StockData
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 20) {
            Image("graph")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
            HStack {
                Text(currentTicker.code).font(.title).bold()
                VStack {
                    HStack {
                        Text("- \(currentTicker.fullName)").foregroundColor(.gray).font(.caption)
                        Spacer()
                        Text("+3.15%").foregroundColor(.green).font(.body)
                    }
                }
                
            }
            
            
            Text(currentTicker.alg)
            
            HStack {
                Spacer()
                NavigationLink(destination: SuggestionDetailsView(details: AlgReturn(profit: 0, percentReturn: 0, trades: [], code: currentTicker.code, alg: currentTicker.alg, prices: [], suggestion: "Hold"))) {
                    Text("\(currentTicker.code) Details")
                }
            }.foregroundColor(.gray)
                .font(.caption)
            
        }
        .padding()
        .background(Rectangle()
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 8)).padding(.bottom, 5)
    }
}

struct HomeCardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCardView(currentTicker: StockData(code: "RIVN", fullName: "Rivian", alg: "Mean Reversion") )
    }
}
