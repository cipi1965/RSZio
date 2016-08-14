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
    var baseURL : String = "http://placehold.it/350x150"
    var expectedURL : String = "http://placehold.it.rsz.io/350x150"
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
        let asyncExpectation = expectationWithDescription("networkAwait")
        var resultImageInfo : ImageInfo? = nil
        try! rszioWrapper.imageInfoAsync({ (imageinfo) in
            resultImageInfo = imageinfo
            asyncExpectation.fulfill()
        }) { (error) in
            asyncExpectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(60) { (error) in
            XCTAssert(resultImageInfo != nil)
        }
    }
    
    func testImage() {
        let asyncExpectation = expectationWithDescription("networkAwait")
        var resultImage : UIImage? = nil
        try! rszioWrapper.buildURL { (builder) -> RSZURLBuilder in
            return builder.width(50, percentage: true)
        }
        try! rszioWrapper.imageAsync({ (image) in
            resultImage = image
            asyncExpectation.fulfill()
        }, callbackError: { (error) in
            asyncExpectation.fulfill()
        })
        self.waitForExpectationsWithTimeout(60) { (error) in
            XCTAssert(resultImage != nil)
        }
    }
    
    func testResizeImage() {
        let asyncExpectation = expectationWithDescription("networkAwait")
        var resultImage : UIImage? = nil
        try! rszioWrapper.buildURL { (builder) -> RSZURLBuilder in
            return builder.width(50, percentage: true)
        }
        try! rszioWrapper.imageAsync({ (image) in
            resultImage = image
            asyncExpectation.fulfill()
            }, callbackError: { (error) in
                asyncExpectation.fulfill()
        })
        self.waitForExpectationsWithTimeout(60) { (error) in
            let imageWidth = resultImage!.size.width * resultImage!.scale
            XCTAssert(imageWidth == 175)
        }
    }
    
}
