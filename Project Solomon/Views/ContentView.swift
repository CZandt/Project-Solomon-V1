//
//  ContentView.swift
//  Project Solomon
//
//  Created by Cole Hardy on 4/28/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "id", ascending:true)]) var tickers: FetchedResults<Ticker>
    
    @State private var showingAddView = false
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                List {
                    ForEach(tickers) {currentTicker in
                        NavigationLink(destination: Text(currentTicker.code!)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(currentTicker.code!)
                                        .bold()
                                }
                                Text("- \(currentTicker.alg!)")
                                Spacer()
                                
                            }
                        }
                    }
                    .onDelete(perform: deleteTicker)
                }
                .listStyle(.plain) //MAYBE DROP THIS
            }
            .navigationTitle("Tickers")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Ticker", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddTickerView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteTicker(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let ticker = tickers[index]
            
            managedObjContext.delete(ticker)
        }
    }
    private func totalTickers() -> Int {
        return 3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
