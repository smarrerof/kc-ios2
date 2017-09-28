//
//  ActivitiesProtocol.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

public protocol ActivitiesProtocol {
    func count() -> Int
    func add(activity: Activity)
    func get(index: Int) -> Activity
}

public class Activities: ActivitiesProtocol {
    private var activityList: [Activity]?
    
    public init() {
        self.activityList = []
    }
    
    public func count() -> Int {
        return (activityList?.count)!
    }
    
    public func add(activity: Activity) {
        activityList?.append(activity)
    }
    
    public func get(index: Int) -> Activity {
        return (activityList?[index])!
    }
}
