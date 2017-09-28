//
//  Activity.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

public class Activity {
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

extension Activity {
    private var _proxyForEquatable : String {
        return "\(name) \(address)"
    }
    
    private var _proxyForHashable: String {
        return "\(name) \(address)"
    }
}

// MARK: - CustomStringConvertible
extension Activity: CustomStringConvertible {
    public var description: String {
        return "Shop: \(name)"
    }
}

// MARK: - Equatable
extension Activity: Equatable {
    public static func ==(lhs: Activity, rhs: Activity) -> Bool {
        return lhs._proxyForEquatable == rhs._proxyForEquatable
    }
}

// MARK: - Hashable
extension Activity: Hashable {
    public var hashValue: Int {
        return _proxyForHashable.hashValue
    }
}

// MARK: - Comparable
extension Activity : Comparable {
    public static func <(lhs: Activity, rhs: Activity) -> Bool {
        return lhs.name < rhs.name || lhs.address < rhs.address
    }
}

