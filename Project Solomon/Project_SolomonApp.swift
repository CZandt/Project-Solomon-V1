//
//  Project_SolomonApp.swift
//  Project Solomon
//
//  Created by Cole Hardy on 4/28/23.
//

import SwiftUI

@main
struct Project_SolomonApp: App {
    @StateObject private var dataController = DataController()
    
    
    var body: some Scene {
        WindowGroup {
            ControllerView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
