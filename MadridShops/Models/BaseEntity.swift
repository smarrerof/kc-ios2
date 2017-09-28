//
//  BaseEntity.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation
import CoreData

@objc protocol BaseEntity {
    static var entityName: String { get }
    
    var address: String? { get set }
    var image: String? { get set }
    var imageData: Data? { get set }
    var info_en: String? { get set }
    var info_es: String? { get set }
    var latitude: Float { get set }
    var logo: String? { get set }
    var logoData: Data? { get set }
    var longitude: Float { get set }
    var mapData: Data? { get set }
    var name: String? { get set }
    var openingHours_en: String? { get set }
    var openingHours_es: String? { get set }
}
