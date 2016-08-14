//
//  RSZioTests.swift
//  RSZioTests
//
//  Created by Matteo Piccina on 12/08/16.
//  Copyright © 2016 Matteo Piccina. All rights reserved.
//

import XCTest
@testable import RSZio

class RSZioTests: XCTestCase {
    var baseURL : String = "http://example.com/image.jpeg"
    var expectedURL : String = "http://example.com.rsz.io/image.jpeg"
    var rszioWrapper : RSZio!
    
    override func setUp() {
        self.rszioWrapper = RSZio(withUrl: NSURL(string: baseURL))
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBase() {
        try! rszioWrapper.buildURL { (builder) -> RSZURLBuilder in return builder.invert().polaroid() }
        print(try! rszioWrapper.builder?.get().absoluteString)
        //XCTAssertEqual(resultURL, NSURL(string: expectedURL))
    }
    
    func testImageInfo() {
        try! rszioWrapper.imageInfoAsync({ (imageinfo) in
            print(imageinfo)
            }) { (error) in
                XCTAssert(false)
                }
    }
    
}
