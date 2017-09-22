//
//  SaveAllShopsInteractor.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/22/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import CoreData

protocol SaveAllShopsInteractor {
    // execute: saves all shops. Return on the main thread
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping shopsSuccessClosure)
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping shopsSuccessClosure, onError: errorClosure)
}
