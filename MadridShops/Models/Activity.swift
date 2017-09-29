//
//  Activity.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

public class Activity: Model { }

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
        return "Activity: \(name)"
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

