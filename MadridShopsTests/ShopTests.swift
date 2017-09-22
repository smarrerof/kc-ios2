//
//  ShopTest.swift
//  MadridShopsTests
//
//  Created by Sergio Marrero Fernandez on 9/21/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import XCTest
import MadridShops

class ShopTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShopCreation() {
        let shop = Shop(name: "Shop 1", address: "Address 1")
        XCTAssertNotNil(shop)
    }
    
    func testShopCustomStringConvertible() {
        let shop = Shop(name: "Shop 1", address: "Address 1")
        
        XCTAssertEqual(shop.description, "Shop: \(shop.name)")
        XCTAssertNotEqual(shop.description, shop.name)
    }
    
    func testShopEquatable() {
        let shop1 = Shop(name: "Shop 1", address: "Address 1")
        let shop2 = Shop(name: "Shop 1", address: "Address 1")
        let shop3 = Shop(name: "Shop 1", address: "Address 2")
        let shop4 = Shop(name: "Shop 2", address: "Address 1")
        let shop5 = Shop(name: "Shop 2", address: "Address 2")
        
        XCTAssertEqual(shop1, shop2)
        
        XCTAssertNotEqual(shop1, shop3)
        XCTAssertNotEqual(shop1, shop4)
        XCTAssertNotEqual(shop1, shop5)
    }
    
    func testShopHashable() {
        let shop = Shop(name: "Shop 1", address: "Address 1")
        
        XCTAssertNotNil(shop.hashValue)
    }
    
    func testShopComparable() {
        let shop1 = Shop(name: "Shop 1", address: "Address 1")
        let shop2 = Shop(name: "Shop 1", address: "Address 2")
        let shop3 = Shop(name: "Shop 2", address: "Address 1")
        let shop4 = Shop(name: "Shop 2", address: "Address 2")
        
        XCTAssertLessThan(shop1, shop2)
        XCTAssertLessThan(shop1, shop3)
        XCTAssertLessThan(shop1, shop4)
    }
}
