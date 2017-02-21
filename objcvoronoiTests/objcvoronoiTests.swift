//
//  objcvoronoiTests.swift
//  objcvoronoiTests
//
//  Created by Eric Freitas on 9/17/16.
//  Copyright © 2016 The Perihelion Group. All rights reserved.
//

import CoreFoundation
import XCTest

class objcvoronoiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testVertexDistance() {
        let vtxA = Vertex(coord: NSPoint(x: 10, y: 10))
        let vtx1 = Vertex(coord: NSPoint(x: 0, y: 0))
        let vtx2 = Vertex(coord: NSPoint(x: 0, y: 20))
        let vtx3 = Vertex(coord: NSPoint(x: 20, y: 20))
        let vtx4 = Vertex(coord: NSPoint(x: 20, y: 0))
        
        let dist1 = vtx1?.distance(to: vtxA)
        let dist2 = vtx2?.distance(to: vtxA)
        let dist3 = vtx3?.distance(to: vtxA)
        let dist4 = vtx4?.distance(to: vtxA)
        
        let correct = Float(sqrt(10*10 + 10*10))
        
        XCTAssert(dist1 == correct, "Distance calculation failed.")
        XCTAssert(dist2 == correct, "Distance calculation failed.")
        XCTAssert(dist3 == correct, "Distance calculation failed.")
        XCTAssert(dist4 == correct, "Distance calculation failed.")
    }
    
}
