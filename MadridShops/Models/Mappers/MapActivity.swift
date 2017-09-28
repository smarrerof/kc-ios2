//
//  MapActivity.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import CoreData

func mapActivityIntoActivityEntity(context: NSManagedObjectContext, activity: Activity) -> ActivityEntity {
    let activityEntity = ActivityEntity(context: context)
    
    activityEntity.name = activity.name
    activityEntity.address = activity.address
    activityEntity.info_en = activity.info_en
    activityEntity.info_es = activity.info_es
    activityEntity.latitude = activity.latitude ?? 0.0
    activityEntity.longitude = activity.longitude ?? 0.0
    activityEntity.logo = activity.logo
    activityEntity.logoData = activity.logoData
    activityEntity.image = activity.image
    activityEntity.imageData = activity.imageData
    activityEntity.openingHours_en = activity.openingHours_en
    activityEntity.openingHours_es = activity.openingHours_es
    activityEntity.mapData = activity.mapData
    
    return activityEntity
}

func mapActivityEntityIntoActivity(activityEntity: ActivityEntity) -> Activity {
    let activity = Activity(name: activityEntity.name ?? "", address: activityEntity.address ?? "")
    
    activity.info_en = activityEntity.info_en ?? ""
    activity.info_es = activityEntity.info_es ?? ""
    activity.latitude = activityEntity.latitude
    activity.longitude = activityEntity.longitude
    activity.logo = activityEntity.logo ?? ""
    activity.logoData = activityEntity.logoData
    activity.image = activityEntity.image ?? ""
    activity.imageData = activityEntity.imageData
    activity.openingHours_en = activityEntity.openingHours_en ?? ""
    activity.openingHours_es = activityEntity.openingHours_es ?? ""
    activity.mapData = activityEntity.mapData
    
    return activity
}

