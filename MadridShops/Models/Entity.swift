//
//  Entity.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/29/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation
import CoreData

protocol EntityProtocol {
    var address: String? { get set }
    var image: String? { get set }
    var imageData: Data? { get set }
    var info_en: String? { get set }
    var info_es: String? { get set }
    var info: String { get }
    var latitude: Float { get set }
    var logo: String? { get set }
    var logoData: Data? { get set }
    var longitude: Float { get set }
    var mapData: Data? { get set }
    var name: String? { get set }
    var openingHours_en: String? { get set }
    var openingHours_es: String? { get set }
    var openingHours: String { get }
}

class BaseEntity: NSManagedObject, EntityProtocol {
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

@objc(ActivityEntity)
class ActivityEntity: BaseEntity { }

@objc(ShopEntity)
class ShopEntity: BaseEntity { }


