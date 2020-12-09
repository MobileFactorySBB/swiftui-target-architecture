//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import Combine
@testable import TargetArchitecture

class ModelTests: XCTestCase {
    
    private var model: Model!
    private var fakeService: FakeService!

    override func setUp() {
        fakeService = FakeService()
        model = Model(service: fakeService)
    }
    
    func testModel() {
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
