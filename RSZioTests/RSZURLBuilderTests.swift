//
//  RSZURLBuilderTests.swift
//  RSZio
//
//  Created by Matteo Piccina on 13/08/16.
//  Copyright © 2016 Matteo Piccina. All rights reserved.
//

import XCTest
@testable import RSZio

class RSZURLBuilderTests: XCTestCase {

    var baseURL : String = "http://example.com/image.jpeg"
    var expectedURL : String = "http://example.com.rsz.io/image.jpeg"
    var builder : RSZURLBuilder!
    
    override func setUp() {
        self.builder = RSZURLBuilder(withUrl: NSURL(string: baseURL))
        super.setUp()
    }
    
    override func tearDown() {
        self.builder = nil
        super.tearDown()
    }

    func testBase() {
        var resultURL : NSURL? = nil
        self.measureBlock {
             resultURL = try! self.builder.get()
        }
        XCTAssertEqual(resultURL, NSURL(string: expectedURL))
    }

}
