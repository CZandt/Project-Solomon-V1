//
//  EditTickerView.swift
//  Project Solomon
//
//  Created by Cole Hardy on 4/28/23.
//

import SwiftUI

struct EditTickerView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment (\.dismiss) var dismiss
    var ticker: FetchedResults<Ticker>.Element
    
    
    @State private var uCode = ""
    @State private var uFullName = ""
    
    var body: some View {
        Form {
            Section {
                TextField("\(ticker.code!)", text: $uCode)
                    .onAppear {
                        uCode = ticker.code!
                        uFullName = ticker.fullName!
                    }
                TextField("\(ticker.fullName!)", text:$uFullName)
                
                HStack {
                    Spacer()
                    Spacer()
                }
            }
        }
    }
}
