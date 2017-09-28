//
//  GetEntitiesFromCacheInteractorImpl.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/29/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation
import CoreData

class GetEntitiesFromCacheInteractorImpl<T>: NSObject, GetEntitiesFromCacheInteractor where T: NSManagedObject {
    var key: String
    var ascending: Bool
    var context: NSManagedObjectContext
    var entityName: String
    
    
    init(key: String, ascending: Bool, context: NSManagedObjectContext, entityName: String) {
        (self.key, self.ascending, self.context, self.entityName) = (key, ascending, context, entityName)
    }
    
    // MARK: - Fetched results controller
    var _fetchedResultsController: NSFetchedResultsController<T>? = nil

    var fetchedResultsController: NSFetchedResultsController<T> {
        if (_fetchedResultsController != nil) {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest<T>(entityName: self.entityName)
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: self.key, ascending: self.ascending)]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        // fetchRequest == SELECT * FROM activities ORDER BY name ASC
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: "\(self.entityName)CacheFile")
        // aFetchedResultsController.delegate = self
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
}
