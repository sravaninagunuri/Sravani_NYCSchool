//
//  ViewControllerTests.swift
//  20230509-SravaniNagunuri-NYCSchoolsTests
//
//  Created by Sravani Nagunuri on 5/10/23.
//

import XCTest
@testable import _0230509_SravaniNagunuri_NYCSchools

class ViewControllerTests: XCTestCase {
    
    var schoolController: SchoolListViewController?
    var detailViewController: SchoolDetailsViewController?

    override func setUpWithError() throws {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let controller = storyBoard.instantiateViewController(withIdentifier: "SchoolsViewControllerID") as? SchoolListViewController {
            controller.loadViewIfNeeded()
            schoolController = controller
        }
    }
    
    override func tearDownWithError() throws {
        schoolController = nil
        detailViewController = nil
    }
        
    func testUtility() {
        if let schoolController = schoolController {
            XCTAssertNoThrow(Utilities.open(scheme: .mailto, urlString: "", contoller: schoolController))
            XCTAssertNoThrow(Utilities.open(scheme: .https, urlString: "www.google.com", contoller: schoolController))
        }
    }

}
