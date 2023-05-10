//
//  EnvironmentTests.swift
//  20230509-SravaniNagunuri-NYCSchoolsUITests
//
//  Created by Sravani Nagunuri on 5/10/23.
//

import XCTest
@testable import _0230509_SravaniNagunuri_NYCSchools

class NYCSchoolTests: XCTestCase {

    func testNYCSchool() {
        XCTAssertEqual(NYCSchool.baseURL.absoluteString, "https://data.cityofnewyork.us")
        XCTAssertEqual(NYCSchool.rootURLstring, NYCSchool.baseURL.absoluteString)
        XCTAssertEqual(NYCSchool.schoolDirectoryURL.path, "/resource/s3k6-pzi2.json")
        XCTAssertEqual(NYCSchool.getResultURL(dbn: "123").path, "/resource/f9bf-2cp4.json")
    }
}
