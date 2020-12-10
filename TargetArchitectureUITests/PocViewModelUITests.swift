//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest

class PocViewModelUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testScenarioOne() throws {
        let app = XCUIApplication()
        app.launchEnvironment.updateValue("scenario1", forKey: "UI_TEST_SCENARIO")
        app.launch()
        
        XCTAssertEqual(app.switches["Start timer"].value as? String, "1")
        app.switches["Start timer"].tap()
        XCTAssertEqual(app.switches["Start timer"].value as? String, "0")
        
        XCTAssertEqual(app.staticTexts["counter_value"].label, "Value: 123")
        app.buttons["Reset"].tap()
        XCTAssertEqual(app.staticTexts["counter_value"].label, "Value: -1")
    }
    
    func testScenarioTwo() throws {
        let app = XCUIApplication()
        app.launchEnvironment.updateValue("scenario2", forKey: "UI_TEST_SCENARIO")
        app.launch()
        
        XCTAssertEqual(app.switches["Start timer"].value as? String, "0")
        app.switches["Start timer"].tap()
        XCTAssertEqual(app.switches["Start timer"].value as? String, "1")
        
        XCTAssertEqual(app.staticTexts["counter_value"].label, "Value: 456")
        app.buttons["Reset"].tap()
        XCTAssertEqual(app.staticTexts["counter_value"].label, "Value: -1")
    }
}
