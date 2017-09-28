//
//  SaveAllActivitiesInteractorImpl.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import CoreData

class SaveAllActivitiesInteractorImpl: SaveAllActivitiesInteractor {
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping activitiesSuccessClosure) {
        execute(activities: activities, context: context, onSuccess: onSuccess, onError: nil)
    }
    
    func execute(activities: Activities, context: NSManagedObjectContext, onSuccess: @escaping activitiesSuccessClosure, onError: errorClosure) {
        for i in 0 ..< activities.count() {
            let activity = activities.get(index: i)
            let _ = mapActivityIntoActivityEntity(context: context, activity: activity)
        }
        
        do {
            try context.save()
            onSuccess(activities)
        } catch {
            // TODO: Error handling
        }
    }
}

