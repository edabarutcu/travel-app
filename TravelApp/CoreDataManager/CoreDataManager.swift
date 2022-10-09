//
//  CoreDataManager.swift
//  TravelApp
//
//  Created by eda on 1.10.2022.
//

import Foundation
import CoreData
//import MapKit

struct CoreDataModel{
    let code: Int
    let name, hotelDescription: String
    let countryCode: String
    let address: String
    let city: String
    let images: String
}
class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func insert(trip: CoreDataModel){
        let managedObjectContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteModel", in: managedObjectContext)!
        let tripModel = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        
        tripModel.setValue(trip.name, forKey: "name")
        tripModel.setValue(trip.images, forKey: "images")
        tripModel.setValue(trip.hotelDescription, forKey: "hotelDescription")
        tripModel.setValue(trip.address, forKey: "address")
        tripModel.setValue(trip.city, forKey: "city")
        tripModel.setValue(trip.countryCode, forKey: "countryCode")
        tripModel.setValue(trip.code, forKey: "code")
        
        do {
            try managedObjectContext.save()
            print("new fav saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getAllTrips() -> [CoreDataModel] {
        let context = self.persistentContainer.viewContext
        var objects:[NSManagedObject] = []
        var products:[CoreDataModel] = []
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "FavoriteModel")
        do {
            objects = try context.fetch(fetchReq)
            print(objects)
            for trips in objects{
                
                let t = CoreDataModel(code: trips.value(forKey: "code") as! Int, name: trips.value(forKey: "name") as! String, hotelDescription: trips.value(forKey: "hotelDescription") as! String, countryCode: trips.value(forKey: "countryCode") as! String, address: trips.value(forKey: "address") as! String, city: trips.value(forKey: "city") as! String, images: trips.value(forKey: "images") as! String)
                products.append(t)
                print(products)
            }
        }catch let error as NSError{
            print(error)
        }
        return products
    }
    
    func deleteCoreData (){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteModel")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let managedObjectContext = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteModel", in: managedObjectContext)!
        
        do {
            try managedObjectContext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
        }
    }
}
