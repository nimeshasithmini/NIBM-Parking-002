//
//  NimeshaUITests.swift
//  NimeshaUITests
//

import XCTest

class NimeshaUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func login_test() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons.element(boundBy: 1).tap();
       
        UIPasteboard.general.string = "admin@nibm.lk"
        let mail = app.textFields["mail"]
        mail.press(forDuration: 1.1)
        app.menuItems["Paste"].tap()
        
        UIPasteboard.general.string = "12345678"
        let pass = app.secureTextFields["password"]
        pass.press(forDuration: 1.1)
        app.menuItems["Paste"].tap()
        
        app.buttons["login_btn"].tap();
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
