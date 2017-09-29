//
//  GetEntitiesFromCacheInteractor.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/29/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import CoreData

protocol GetEntitiesFromCacheInteractor {
    associatedtype T where T: NSManagedObject, T: EntityProtocol
    
    var fetchedResultsController: NSFetchedResultsController<T> { get }

}
