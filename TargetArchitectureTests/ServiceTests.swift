//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import Combine
@testable import TargetArchitecture

class ServiceTests: XCTestCase {
    
    private var service: Service!
    
    override func setUp() {
        service = Service()
    }
    
    func testServiceDoesNothingAfterInit() {
        let expectation = self.expectation(description: "wait for service timer")
        
        let sub = service.clock.sink(receiveCompletion: { _ in
            XCTFail()
        }, receiveValue: { value in
            XCTFail()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { _ in
            sub.cancel()
        }
    }
    
    func testServiceSendEverySecondsWhenStarted() {
        let expectation = self.expectation(description: "wait for service timer")
        
        var i = 0
        let start = Date()
        let sub = service.clock.sink(receiveCompletion: { _ in
            XCTFail()
        }, receiveValue: { value in
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
        })
        service.startClock()
        
        waitForExpectations(timeout: 5.0) { _ in
            sub.cancel()
        }
    }
    
    func testServiceStopsSendingWhenStopped() {
        let expectation = self.expectation(description: "wait for service timer")
        
        var i = 0
        let start = Date()
        let sub = service.clock.sink(receiveCompletion: { _ in
            XCTFail()
        }, receiveValue: { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(start.timeIntervalSinceNow, -1.0, accuracy: 0.5)
                self.service.stopClock()
            default:
                XCTFail()
            }
        })
        service.startClock()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { _ in
            sub.cancel()
        }
    }
}
