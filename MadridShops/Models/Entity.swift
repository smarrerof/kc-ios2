//
//  Entity.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/29/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation
import CoreData

class Entity: NSManagedObject, EntityProtocol {
    @NSManaged public var address: String?
    @NSManaged public var image: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var info_en: String?
    @NSManaged public var info_es: String?
    var info: String {
        if let languageCode = Locale.current.languageCode {
            switch languageCode {
            case "es": return info_es!
            default: return info_en!
            }
        }
        return info_en!
    }
    @NSManaged public var latitude: Float
    @NSManaged public var logo: String?
    @NSManaged public var logoData: Data?
    @NSManaged public var longitude: Float
    @NSManaged public var mapData: Data?
    @NSManaged public var name: String?
    @NSManaged public var openingHours_en: String?
    @NSManaged public var openingHours_es: String?
    var openingHours: String {
        if let languageCode = Locale.current.languageCode {
            switch languageCode {
            case "es": return openingHours_es!
            default: return openingHours_en!
            }
        }
        return openingHours_en!
    }
}
