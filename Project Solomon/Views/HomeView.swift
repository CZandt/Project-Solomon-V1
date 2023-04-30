//
//  HomeView.swift
//  Project Solomon
//
//  Created by Cole Hardy on 4/28/23.
//

import SwiftUI

struct HomeView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "id", ascending:true)]) var tickers: FetchedResults<Ticker>
    
    @State var stockObj:[AlgReturn] = [AlgReturn(profit: 0, percentReturn: 0, trades: [], code: "TEST", alg: "TEST", prices: [], suggestion: "")]
    
    var body: some View {
        ZStack {
            NavigationView{
                VStack(alignment: .leading) {
                    Text("Project Solomon")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                    List {
                        ForEach(tickers) {currentTicker in
                            
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Image("graph")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(10)
                                HStack {
                                    Text(currentTicker.code!).font(.title).bold()
                                    VStack {
                                        HStack {
                                            Text("- \(currentTicker.fullName!)").foregroundColor(.gray).font(.caption)
                                            Spacer()
                                            Text("+3.15%").foregroundColor(.green).font(.body)
                                        }
                                    }
                                    
                                }
                                
                                
                                Text(currentTicker.alg!)
                                
                                HStack {
                                    Spacer()
                                    NavigationLink(destination: SuggestionDetailsView(details: AlgReturn(profit: 0, percentReturn: 0, trades: [], code: currentTicker.code!, alg: currentTicker.alg!, prices: [], suggestion: "TEST"))) {
                                        Text("\(currentTicker.code!) Details")
                                    }
                                }.foregroundColor(.gray)
                                    .font(.caption)
                                
                            }
                            .padding()
                            .background(Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 8)).padding(.bottom, 5)
                            }.listRowSeparator(.hidden)
                    }.listRowSeparator(.hidden).listStyle(.plain)
                }
                }
                .navigationTitle("Project Solomon")
            }
        }
    }

//mutating func loadData(tickers:FetchedResults<Ticker>, stockObj:[AlgReturn]) {
//    for ticker in tickers {
//        stockObj.append(AlgReturn(profit: 0, percentReturn: 0, trades: [], code: ticker.code!, alg: ticker.alg!, prices: [], suggestion: "" ))
//    }
//}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
