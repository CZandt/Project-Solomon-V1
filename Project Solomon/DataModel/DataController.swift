//
//  DataController.swift
//  Project Solomon
//
//  Created by Cole Hardy on 4/28/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "TickerModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Save Succesful")
            
        } catch {
            print("FAILED DATA SAVEd")
        }
    }
    
    func addTicker(uCode: String, fullName: String, uAlg:String, context: NSManagedObjectContext) {
        let ticker = Ticker(context: context)
        ticker.id = UUID()
        ticker.fullName = fullName
        ticker.code = uCode
        ticker.alg = uAlg
        
        save(context: context)
        
    }
    
    func editTicker(ticker: Ticker, uCode: String, fullName: String, context: NSManagedObjectContext) {
        ticker.code = uCode
        ticker.fullName = fullName
        
        save(context: context)
    }
}
