//
//  SiteTests.swift
//  objcvoronoi
//
//  Created by Eric Freitas on 10/31/16.
//  Copyright © 2016 The Perihelion Group. All rights reserved.
//

import AppKit
import XCTest
//import objcvoronoi


class SiteTests: XCTestCase {

    var points = NSMutableArray()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        points.add(Site(coord: NSPoint(x: 261, y: 439)))
        points.add(Site(coord: NSPoint(x: 371, y: 87)))
        points.add(Site(coord: NSPoint(x: 102, y: 553)))
        points.add(Site(coord: NSPoint(x: 427, y: 384)))
        points.add(Site(coord: NSPoint(x: 301, y: 24)))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSort() {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        /*
        Original:
        <__NSArrayM 0x61000004ebb0>(
            (coord: {261, 439}, voronoiId: 0),
            (coord: {371, 87}, voronoiId: 0),
            (coord: {102, 553}, voronoiId: 0),
            (coord: {427, 384}, voronoiId: 0),
            (coord: {301, 24}, voronoiId: 0)
        )
        
        Sorted should be:
        <__NSArrayM 0x608000046ff0>(
            (coord: {102, 553}, voronoiId: 0),
            (coord: {261, 439}, voronoiId: 0),
            (coord: {427, 384}, voronoiId: 0),
            (coord: {371, 87}, voronoiId: 0),
            (coord: {301, 24}, voronoiId: 0)
        */
        
        debugPrint("Before Sort:")
        debugPrint(points)
        
        
        let sortedPoints = Site.sortSites(points)
        
        if let firstPoint = sortedPoints?[0] as! Site? {
            XCTAssert(firstPoint.coord.x == 102, "Error in Site.sortSites()")
            XCTAssert(firstPoint.coord.y == 553, "Error in Site.sortSites()")
        }
        if let secondPoint = sortedPoints?[1] as! Site? {
            XCTAssert(secondPoint.coord.x == 261, "Error in Site.sortSites()")
            XCTAssert(secondPoint.coord.y == 439, "Error in Site.sortSites()")
        }
        if let thirdPoint = sortedPoints?[2] as! Site? {
            XCTAssert(thirdPoint.coord.x == 427, "Error in Site.sortSites()")
            XCTAssert(thirdPoint.coord.y == 384, "Error in Site.sortSites()")
        }
        if let fourthPoint = sortedPoints?[3] as! Site? {
            XCTAssert(fourthPoint.coord.x == 371, "Error in Site.sortSites()")
            XCTAssert(fourthPoint.coord.y == 87, "Error in Site.sortSites()")
        }
        if let fifthPoint = sortedPoints?[4] as! Site? {
            XCTAssert(fifthPoint.coord.x == 301, "Error in Site.sortSites()")
            XCTAssert(fifthPoint.coord.y == 24, "Error in Site.sortSites()")
        }
        
    }

}
