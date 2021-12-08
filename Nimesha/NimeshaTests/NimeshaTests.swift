//
//  NimeshaTests.swift
//  NimeshaTests
//

import XCTest
@testable import Nimesha

class NimeshaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_sign_out() throws {
        let controller = UserController()
        controller.sign_out();
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
