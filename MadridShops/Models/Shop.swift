//
//  Shop.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/19/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

public class Shop: Model { }

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
