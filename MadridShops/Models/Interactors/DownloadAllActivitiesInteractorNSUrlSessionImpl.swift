//
//  DownloadAllActivitiesInteractorNSUrlSessionImpl.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

class DownloadAllActivitiesInteractorNSUrlSessionImpl: DownloadAllActivitiesInteractor {
    func execute(onSuccess: @escaping activitiesSuccessClosure) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    func execute(onSuccess: @escaping activitiesSuccessClosure, onError: errorClosure = nil) {
        let urlString = "https://madrid-shops.com/json_new/getActivities.php"
        
        let session = URLSession.shared
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                let activities = parseActivity(data: data!)
                
                // Download images (at this point we are in another thread, so, Thread.current != Thread.main)
                assert(Thread.current != Thread.main)
                for i in 0 ..< activities.count() {
                    let activity = activities.get(index: i)
                    
                    activity.logoData = activity.logo.downloadImage()
                    activity.imageData = activity.image.downloadImage()
                    
                    let mapUrl = "https://maps.googleapis.com/maps/api/staticmap?center=\(activity.latitude!),\(activity.longitude!)&zoom=17&size=375x150&scale=1&markers=\(activity.latitude!),\(activity.longitude!)"
                    activity.mapData = mapUrl.downloadImage()
                }
                
                // Return to main thread and call the onSuccess closure
                OperationQueue.main.addOperation {
                    assert(Thread.current == Thread.main)
                    if error == nil {
                        // OK
                        onSuccess(activities)
                    } else {
                        // ERROR
                        if let onError = onError {
                            onError(error!)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
