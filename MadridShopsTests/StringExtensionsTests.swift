//
//  StringExtensionsTests.swift
//  MadridShopsTests
//
//  Created by Sergio Marrero Fernandez on 10/1/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import XCTest
@testable import MadridShops

class StringExtensionsTests: XCTestCase {
    
    func testParseLatLong() {
        XCTAssertEqual("23.12".parseLatLong(), Float(23.12))
        XCTAssertEqual("23,12".parseLatLong(), Float(2312))
        XCTAssertEqual("23.12,".parseLatLong(), Float(23.12))
        XCTAssertEqual("23.12 ".parseLatLong(), Float(23.12))
        XCTAssertEqual("23.12     ".parseLatLong(), Float(23.12))
        XCTAssertNil("23.12a".parseLatLong())
    }
    
}
