//
//  ActivityAnnotation.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation
import MapKit

class ActivityAnnotation: NSObject, MKAnnotation {
    var activityEntity: ActivityEntity
    
    var coordinate: CLLocationCoordinate2D {
        let activityLocation = CLLocation(latitude: Double(activityEntity.latitude), longitude: Double(activityEntity.longitude))
        return activityLocation.coordinate
    }
    
    var title: String? {
        return activityEntity.name
    }
    var subtitle: String? {
        return activityEntity.address
    }
    
    init(activityEntity: ActivityEntity) {
        self.activityEntity = activityEntity
    }
}
