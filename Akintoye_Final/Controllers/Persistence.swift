//
//  Persistence.swift
//  Akintoye_Final
//
//  Created by Arogs on 3/12/24.
//

import Foundation

import CoreData

struct PersistenceController{
    
    static let shared = PersistenceController()
    let container : NSPersistentContainer
    
    static var preview : PersistenceController = {
        //inMemory - true : data will not be save permanently
        let result = PersistenceController(inMemory : true)
        let viewContext = result.container.viewContext
        return result
    }()
    
    init(inMemory : Bool = false) {
        self.container = NSPersistentContainer(name: "LibraryModel")
        
        if inMemory{
            self.container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        self.container.loadPersistentStores(completionHandler: { (storeDescription , error) in
            if let error = error as NSError?{
                print(#function, "Unable to connect to CoreData : \(error)")
            }
        })
    }
    
}
