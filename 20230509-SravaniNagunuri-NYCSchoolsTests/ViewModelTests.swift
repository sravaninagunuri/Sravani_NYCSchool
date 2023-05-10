//
//  ViewModelTests.swift
//  20230509-SravaniNagunuri-NYCSchoolsUITests
//
//  Created by Sravani Nagunuri on 5/10/23.
//


import XCTest
@testable import _0230509_SravaniNagunuri_NYCSchools

class ViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDetailViewModelTests() {
        let detailViewModel = SchoolDetailsViewModel()
        let expectation = XCTestExpectation(description: "wait for url response")

        if let school = UtilitiesTests.getSchoolModel(dbn: "01M292"){
            detailViewModel.getDetails(forSelectedSchool: school) { (response: [SATScore]?, error) in
                expectation.fulfill()
                XCTAssertNotNil(response)
                let score = response?.first
                XCTAssertNotNil(score)
                XCTAssertEqual(score?.dbn, school.dbn)
            }
        }
    }
    
    func testDetailViewModelErrorTests() {
        let detailViewModel = SchoolDetailsViewModel()
        let expectation = XCTestExpectation(description: "wait for url response")

        if let school = UtilitiesTests.getSchoolModel(dbn: "01M2432"){
            detailViewModel.getDetails(forSelectedSchool: school) { (response: [SATScore]?, error) in
                expectation.fulfill()
                XCTAssertNil(response)
            }
        }
    }
}
