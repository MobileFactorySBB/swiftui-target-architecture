//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import Combine
@testable import TargetArchitecture

class CounterTests: XCTestCase {
    
    private var counter: Counter!
    private var fakeClock: FakeClock!
    
    override func setUp() {
        fakeClock = FakeClock()
        counter = Counter(service: fakeClock)
    }
    
    func testCounterIsInitiallyStopped() {
        XCTAssertFalse(counter.isCounterStarted)
    }
    
    func testCounterIsInitiallySetToZero() {
        let expectation = self.expectation(description: "wait for counter")
        
        var i = 0
        let sub = counter.counter.sink { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(value, 0)
                expectation.fulfill()
            default:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5.0) { _ in
            sub.cancel()
        }
    }
    
    func testStartingCounterStartsClockService() {
        counter.isCounterStarted = true
        
        XCTAssertTrue(fakeClock.clockWasStarted)
    }
    
    func testReceivingAClockEventIncrementsCounter() {
        let expectation = self.expectation(description: "wait for counter")
        
        var i = 0
        let sub = counter.counter.sink { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(value, 0)
                self.fakeClock.clockSubject.send(Date())
            case 2:
                XCTAssertEqual(value, 1)
                expectation.fulfill()
            default:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5.0) { _ in
            sub.cancel()
        }
    }
    
    func testStoppingCounterStopsClockService() {
        counter.isCounterStarted = false
        
        XCTAssertTrue(fakeClock.clockWasStopped)
    }
    
    func testResetingCounterSetValueToZero() {
        let expectation = self.expectation(description: "wait for counter")
        
        var i = 0
        let sub = counter.counter.sink { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(value, 0)
                self.counter.resetCounter()
            case 2:
                XCTAssertEqual(value, 0)
                expectation.fulfill()
            default:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5.0) { _ in
            sub.cancel()
        }
    }
    
    func testReceivingAClockErrorSetCounterToZero() {
        let expectation = self.expectation(description: "wait for counter")
        
        var i = 0
        let sub = counter.counter.sink { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(value, 0)
                self.fakeClock.clockSubject.send(Date())
            case 2:
                XCTAssertEqual(value, 1)
                self.fakeClock.clockSubject.send(completion: .failure(.invalid))
            case 3:
                XCTAssertEqual(value, 0)
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
