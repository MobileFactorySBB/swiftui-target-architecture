//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import Combine
@testable import TargetArchitecture

class ClockTests: XCTestCase {
    
    private var clock: Clock!
    
    override func setUp() {
        clock = Clock()
    }
    
    func testClockDoesNothingAfterInit() {
        let expectation = self.expectation(description: "wait for service timer")
        
        let sub = clock.clock.sink(receiveCompletion: { _ in
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
    
    func testClockSendEverySecondsWhenStarted() {
        let expectation = self.expectation(description: "wait for service timer")
        
        var i = 0
        let start = Date()
        let sub = clock.clock.sink(receiveCompletion: { _ in
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
        clock.startClock()
        
        waitForExpectations(timeout: 5.0) { _ in
            sub.cancel()
        }
    }
    
    func testClockStopsSendingWhenStopped() {
        let expectation = self.expectation(description: "wait for service timer")
        
        var i = 0
        let start = Date()
        let sub = clock.clock.sink(receiveCompletion: { _ in
            XCTFail()
        }, receiveValue: { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(start.timeIntervalSinceNow, -1.0, accuracy: 0.5)
                self.clock.stopClock()
            default:
                XCTFail()
            }
        })
        clock.startClock()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { _ in
            sub.cancel()
        }
    }
}
