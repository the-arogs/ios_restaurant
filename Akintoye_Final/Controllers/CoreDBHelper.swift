//
//  CoreDBHelper.swift
//  Akintoye_Final
//
//  Created by Arogs on 3/12/24.
//

import Foundation
import CoreData

//MVC - Controller

class CoreDBHelper : ObservableObject{
    
    @Published var restaurantList = [RestaurantMO]()
    
    //singleton instance
    private static var shared: CoreDBHelper?
    private let ENTITY_NAME = "RestaurantMO" 
    private let moc : NSManagedObjectContext
    
    static func getInstance() -> CoreDBHelper{
        if shared == nil{
            shared = CoreDBHelper(moc: PersistenceController.preview.container.viewContext)
        }
        
        return shared!
    }
    
    init(moc : NSManagedObjectContext) {
        self.moc = moc
    }
    
    func insertRestaurant(newRestaurant: Restaurant){
        do{
            //obtain the object reference of NSEntityDescription
            let restaurantToInsert = NSEntityDescription.insertNewObject(forEntityName: self.ENTITY_NAME, into: self.moc) as! RestaurantMO
            
            //assign the values to object reference
            restaurantToInsert.restaurant = newRestaurant.restaurant
            restaurantToInsert.latitude = newRestaurant.latitude
            restaurantToInsert.longitude = newRestaurant.longitude
            
            //save the object to db
            if self.moc.hasChanges{
                try self.moc.save()
                
                print(#function, "Restaurant successfully saved to db")
            }

        }catch let error as NSError{
            print(#function, "Could not insert restaurant successfully \(error)")
        }
    }
    
    func getAllRestaurants(){

        let request = NSFetchRequest<RestaurantMO>(entityName: self.ENTITY_NAME)
        request.sortDescriptors = [NSSortDescriptor.init(key: "restaurant", ascending: true)]
        
        do{

            let result = try self.moc.fetch(request)
            
            print(#function, "\(result.count) restaurants fetched frpm db")
            
            self.restaurantList.removeAll()
            self.restaurantList.insert(contentsOf: result, at: 0)
            
        }catch let error as NSError{
            print(#function, "Couldn't fetch data from DB \(error)")
        }
    }
}
