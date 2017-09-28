
//
//  ShopAnnotation2.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation
import MapKit

class Shop2Annotation<TEntity>: NSObject, MKAnnotation where TEntity: BaseEntity {
    var shopEntity: TEntity
    
    var coordinate: CLLocationCoordinate2D {
        let shopLocation = CLLocation(latitude: Double(shopEntity.latitude), longitude: Double(shopEntity.longitude))
        return shopLocation.coordinate
    }
    
    var title: String? {
        return shopEntity.name
    }
    var subtitle: String? {
        return shopEntity.address
    }
    
    init(shopEntity: TEntity) {
        self.shopEntity = shopEntity
    }
}
