//
//  Shop.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/19/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

public class Shop {
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

extension Shop {
    private var _proxyForEquatable : String {
        return "\(name) \(address)"
    }
    
    private var _proxyForHashable: String {
        return "\(name) \(address)"
    }
}

// MARK: - CustomStringConvertible
extension Shop: CustomStringConvertible {
    public var description: String {
        return "Shop: \(name)"
    }
}

// MARK: - Equatable
extension Shop: Equatable {
    public static func ==(lhs: Shop, rhs: Shop) -> Bool {
        return lhs._proxyForEquatable == rhs._proxyForEquatable
    }
}

// MARK: - Hashable
extension Shop: Hashable {
    public var hashValue: Int {
        return _proxyForHashable.hashValue
    }
}

// MARK: - Comparable
extension Shop : Comparable {
    public static func <(lhs: Shop, rhs: Shop) -> Bool {
        return lhs.name < rhs.name || lhs.address < rhs.address
    }
}
