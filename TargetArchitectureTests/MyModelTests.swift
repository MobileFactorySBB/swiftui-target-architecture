//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import Combine
@testable import TargetArchitecture

class MyModelTests: XCTestCase {
    
    private var model: MyModel!
    private var fakeService: MyFakeService!

    override func setUp() {
        fakeService = MyFakeService()
        model = MyModel(service: fakeService)
    }
    
    func testMyModel() {
        let expectation = self.expectation(description: "wait...")
        
        let date = Date()
        let sub = model.values.sink { value in
            XCTAssertEqual(value, date.description)
            expectation.fulfill()
        }
        fakeService.valuesSubject.send(date)
        
        waitForExpectations(timeout: 5.0) { _ in
            sub.cancel()
        }
    }
}
