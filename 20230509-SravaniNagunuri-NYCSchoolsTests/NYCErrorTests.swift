//
//  NYCErrorTests.swift
//  20230509-SravaniNagunuri-NYCSchoolsUITests
//
//  Created by Sravani Nagunuri on 5/10/23.
//

import XCTest
@testable import _0230509_SravaniNagunuri_NYCSchools

class NYCErrorTests: XCTestCase {
    
    func testError() throws {
        let error1 = NYCError.internalServerError
        XCTAssertEqual("Internal server error.", error1.localizedDescription)
        let error2 = NYCError.noInternetConnection
        XCTAssertEqual("Not connected to Internet.", error2.localizedDescription)
        let error3 = NYCError.timeout
        XCTAssertEqual("Request timed out.", error3.localizedDescription)
        let error4 = NYCError.other(statusCode: 400, response: nil)
        XCTAssertEqual("Error occured. Please try agiain!", error4.localizedDescription)

    }
}
