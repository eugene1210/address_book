//
//  CoreDataUtils.swift
//  Address Book
//
//  Created by Admin on 18.11.2021.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit
import CoreData

class CoreDataUtils {
    
    init() {}
    
    static func saveLocationFav(locationName: String, locationSub: String) -> LocationFav? {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "LocationFav", in: context) else { return nil }
        let locationFav = NSManagedObject(entity: entity, insertInto: context) as! LocationFav
        
        locationFav.locationName = locationName
        locationFav.locationSubname = locationSub
        locationFav.id = UUID()
        
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
        return locationFav
    }
    
    static func fetchLocationFavs() -> [LocationFav] {
        var locationFavs: [LocationFav] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetch: NSFetchRequest<LocationFav> = LocationFav.fetchRequest()
       
        do {
            locationFavs = try context.fetch(fetch)
        } catch {
            print(error.localizedDescription)
        }
        return locationFavs
        
    }
    
    static func deleteLocationFav(locationFav: LocationFav) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<LocationFav> = LocationFav.fetchRequest()
        
        if let locationFavs = try? context.fetch(fetchRequest) {
            for fav in locationFavs {
                if fav.id == locationFav.id {
                    context.delete(fav)
                    break
                }
            }
        }
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
