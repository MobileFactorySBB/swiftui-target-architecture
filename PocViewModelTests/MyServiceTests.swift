//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import Combine
@testable import PocViewModel

class MyServiceTests: XCTestCase {
    
    private var service: MyService!

    override func setUp() {
        service = MyService()
    }

    func testMyService() {
        let expectation = self.expectation(description: "wait...")
        
        var i = 0
        let start = Date()
        let sub = service.values.sink { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(start.timeIntervalSinceNow, -1.0, accuracy: 0.5)
            case 2:
                XCTAssertEqual(start.timeIntervalSinceNow, -2.0, accuracy: 0.5)
            case 3:
                XCTAssertEqual(start.timeIntervalSinceNow, -3.0, accuracy: 0.5)
                expectation.fulfill()
            default:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5.0) { _ in
            sub.cancel()
        }
    }
}
