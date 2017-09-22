//
//  ShopsTests.swift
//  MadridShopsTests
//
//  Created by Sergio Marrero Fernandez on 9/19/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import XCTest
import MadridShops

class ShopsTests: XCTestCase {
    
    func testGivenEmptyShopsNumberShopsIsZero() {
        let sut = Shops()
        XCTAssertEqual(0, sut.count())
    }
    
    func testGivenShopsWithOneElementNumberShopsIsOne() {
        let sut = Shops()
        sut.add(shop: Shop(name: "Shop", address: "Address"))
        XCTAssertEqual(1, sut.count())
    }
}
