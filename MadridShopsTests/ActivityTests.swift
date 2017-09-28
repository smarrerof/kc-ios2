//
//  Activity.swift
//  MadridShopsTests
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import XCTest
import MadridShops

class ActivityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShopCreation() {
        let activity = Activity(name: "Activity 1", address: "Address 1")
        XCTAssertNotNil(activity)
    }
    
    func testShopCustomStringConvertible() {
        let activity = Activity(name: "Activity 1", address: "Address 1")
        
        XCTAssertEqual(activity.description, "Activity: \(activity.name)")
        XCTAssertNotEqual(activity.description, activity.name)
    }
    
    func testShopEquatable() {
        let activity1 = Activity(name: "Activity 1", address: "Address 1")
        let activity2 = Activity(name: "Activity 1", address: "Address 1")
        let activity3 = Activity(name: "Activity 1", address: "Address 2")
        let activity4 = Activity(name: "Activity 2", address: "Address 1")
        let activity5 = Activity(name: "Activity 2", address: "Address 2")
        
        XCTAssertEqual(activity1, activity2)
        
        XCTAssertNotEqual(activity1, activity3)
        XCTAssertNotEqual(activity1, activity4)
        XCTAssertNotEqual(activity1, activity5)
    }
    
    func testShopHashable() {
        let activity = Activity(name: "Activity 1", address: "Address 1")
        
        XCTAssertNotNil(activity.hashValue)
    }
    
    func testShopComparable() {
        let activity1 = Shop(name: "Activity 1", address: "Address 1")
        let activity2 = Shop(name: "Activity 1", address: "Address 2")
        let activity3 = Shop(name: "Activity 2", address: "Address 1")
        let activity4 = Shop(name: "Activity 2", address: "Address 2")
        
        XCTAssertLessThan(activity1, activity2)
        XCTAssertLessThan(activity2, activity3)
        XCTAssertLessThan(activity1, activity4)
    }
}

