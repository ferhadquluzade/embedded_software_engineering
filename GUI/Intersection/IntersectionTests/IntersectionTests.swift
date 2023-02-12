//
//  IntersectionTests.swift
//  IntersectionTests
//
//  Created by Zaur Gurbanli on 12.01.23.
//

import XCTest

final class IntersectionTests: XCTestCase {
    private var road: Road!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        road = Road(numberOfCars: 1, remainingTime: 2, hasEmergencyCar: false, name: "Road1");
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        road = nil;
        
    }

    func testNumberOfCarsInRoad(){
        let numberOfCars = 1
        XCTAssertEqual(road.numberOfCars, numberOfCars)
    }
    func testRemainingTimeInRoad(){
        let remainingTime = 2
        XCTAssertEqual(road.remainingTime, remainingTime)
    }
    
    func testHasEmergencyCarInRoad(){
        let hasEmergencyCar = false;
        XCTAssertEqual(road.hasEmergencyCar, hasEmergencyCar)
    }
    func testNameOfRoad(){
        let name = "Road1"
        XCTAssertEqual(road.name, name)
    }
    
    func testDisableButton(){
        let carName = "Car1"
        let time = ""
        let isDisabled = disabledButton(carName, time);
        XCTAssertTrue(isDisabled)
    }

}
