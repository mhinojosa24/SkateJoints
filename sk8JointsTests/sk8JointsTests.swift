//
//  sk8JointsTests.swift
//  sk8JointsTests
//
//  Created by Student Loaner 3 on 10/19/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import XCTest
@testable import sk8Joints

class sk8JointsTests: XCTestCase {
    var soMaSkatePark: Spot!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        soMaSkatePark = Spot(id: "asdfag89sdf98fasd8f", spotName: "Soma", spotImage: "asdfasdfa23", address: "Central Fwy, San Francisco, CA 94103", spotLat: 37.7701, spotLong: 122.4215, verifySpot: 3)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        soMaSkatePark = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here...
        }
    }

}
