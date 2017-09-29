//
//  EntityAnnotation.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/29/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation
import MapKit

class EntityAnnotation: NSObject, MKAnnotation {
    var entity: EntityProtocol
    
    var coordinate: CLLocationCoordinate2D {
        let shopLocation = CLLocation(latitude: Double(entity.latitude), longitude: Double(entity.longitude))
        return shopLocation.coordinate
    }
    
    var title: String? {
        return entity.name
    }
    var subtitle: String? {
        return entity.address
    }
    
    init(entity: EntityProtocol) {
        self.entity = entity
    }
}
