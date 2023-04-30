//
//  AddTickerView.swift
//  Project Solomon
//
//  Created by Cole Hardy on 4/28/23.
//

import SwiftUI

struct AddTickerView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment (\.dismiss) var dismiss
    
    @State private var uTicker = ""
    @State private var uFullName = ""
    @State private var uAlg = ""
    let algs = ["Mean Reversion", "Simple Moving Average", "SARIMAX", "MAGI"]
    
    var body: some View {
        Form {
            Section {
                TextField("Stock Name", text: $uFullName)
                TextField("Ticker", text: $uTicker)
                Picker("Algorithim", selection: $uAlg) {
                    ForEach(algs, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.automatic)
                
                HStack {
                    Spacer()
                    Button("Add Stock") {
                        DataController().addTicker(uCode: uTicker, fullName: uFullName, uAlg: uAlg, context: managedObjContext) // Submits the data to the database
                        
                        dismiss() // Dismisses the popup for the view
                    }
                    Spacer()
                }
            }
            
        }
    }
}

struct AddTickerView_Previews: PreviewProvider {
    static var previews: some View {
        AddTickerView()
    }
}
