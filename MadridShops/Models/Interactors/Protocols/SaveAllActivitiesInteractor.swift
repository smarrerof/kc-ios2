//
//  SaveAllActivitiesInteractor.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import CoreData

protocol SaveAllActivitiesInteractor {
    // execute: saves all activities. Return on the main thread
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping activitiesSuccessClosure)
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping activitiesSuccessClosure, onError: errorClosure)
}
