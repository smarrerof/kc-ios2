//
//  Model.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/29/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

protocol ModelProtocol {
    var name: String { get set }
    var address: String { get set }
    var info_en: String { get set }
    var info_es: String { get set }
    var info: String { get }
    var latitude: Float? { get set }
    var longitude: Float? { get set }
    var logo: String { get set }
    var logoData: Data? { get set }
    var image: String { get set }
    var imageData: Data? { get set }
    var openingHours_en: String { get set }
    var openingHours_es: String { get set }
    var openingHours: String { get }
    var mapData: Data? { get set }
}

public class Model: ModelProtocol {
    public var name: String
    var address: String = ""
    var info_en: String = ""
    var info_es: String = ""
    var info: String {
        if let languageCode = Locale.current.languageCode {
            switch languageCode {
            case "es": return info_es
            default: return info_en
            }
        }
        return info_en
    }
    var latitude: Float? = nil
    var longitude: Float? = nil
    var logo: String = ""
    var logoData: Data?
    var image: String = ""
    var imageData: Data?
    var openingHours_en: String = ""
    var openingHours_es: String = ""
    var openingHours: String {
        if let languageCode = Locale.current.languageCode {
            switch languageCode {
            case "es": return openingHours_es
            default: return openingHours_en
            }
        }
        return openingHours_en
    }
    var mapData: Data?
    
    
    public init(name: String, address: String) {
        (self.name, self.address) = (name, address)
    }
}
