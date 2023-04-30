//
//  ControllerView.swift
//  Project Solomon
//
//  Created by Cole Hardy on 4/28/23.
//

import SwiftUI

struct ControllerView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem() {
                    Image(systemName: "house")
                    Text("Home")
                }
            PredictView()
                .tabItem() {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Predict")
                }
            ContentView()
                .tabItem() {
                    Image(systemName: "line.3.horizontal")
                    Text("Tickers")
                }
            
            
        }
    }
}

struct ControllerView_Previews: PreviewProvider {
    static var previews: some View {
        ControllerView()
    }
}
