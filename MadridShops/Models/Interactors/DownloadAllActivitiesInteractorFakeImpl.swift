//
//  DownloadAllActivitiesInteractorFakeImpl.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

final class DownloadAllActivitiesInteractorFakeImpl: DownloadAllActivitiesInteractor {
    func execute(onSuccess: @escaping activitiesSuccessClosure) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    func execute(onSuccess: @escaping activitiesSuccessClosure, onError: errorClosure = nil) {
        let activities = Activities()
        
        for i in 1...5 {
            let activity = Activity(name: "Activity \( i )", address: "Address \( i )")
            activity.logo = "https://lorempixel.com/100/100/"
            activity.image = "https://lorempixel.com/800/600"
            activity.info_en = "EN - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum nibh ex, ut tristique ex iaculis sed. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed magna turpis, pharetra ac malesuada nec, pulvinar rutrum lorem. Aliquam massa tellus, molestie in convallis ac, vehicula non quam. Etiam ut accumsan sapien. Quisque sollicitudin quam et velit rutrum, id placerat purus eleifend. Nullam a consectetur eros. Ut volutpat lacus sed fringilla facilisis. Etiam interdum velit nec sapien lacinia, id eleifend neque dictum."
            activity.info_es = "ES - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum nibh ex, ut tristique ex iaculis sed. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed magna turpis, pharetra ac malesuada nec, pulvinar rutrum lorem. Aliquam massa tellus, molestie in convallis ac, vehicula non quam. Etiam ut accumsan sapien. Quisque sollicitudin quam et velit rutrum, id placerat purus eleifend. Nullam a consectetur eros. Ut volutpat lacus sed fringilla facilisis. Etiam interdum velit nec sapien lacinia, id eleifend neque dictum."
            activity.openingHours_en = "Monday to Saturday from 10:00 to 22:00"
            activity.openingHours_es = "Lunes a sabado de 10:00 a 22:00"
            
            if let url = URL(string: activity.logo), let logoData = NSData(contentsOf: url) {
                activity.logoData = logoData as Data
            }
            if let url = URL(string: activity.image), let imageData = NSData(contentsOf: url) {
                activity.imageData = imageData as Data
            }
            
            activities.add(activity: activity)
        }
        
        OperationQueue.main.addOperation {
            onSuccess(activities)
        }
    }
}
