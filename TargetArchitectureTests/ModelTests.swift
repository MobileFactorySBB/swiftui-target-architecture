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
    
    func testCounterIsInitiallyStopped() {
        XCTAssertFalse(model.isCounterStarted)
    }
    
    func testCounterIsInitiallySetToZero() {
        let expectation = self.expectation(description: "wait for counter")
        
        var i = 0
        let sub = model.counter.sink { value in
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
        model.isCounterStarted = true
        
        XCTAssertTrue(fakeService.clockWasStarted)
    }
    
    func testReceivingAClockEventIncrementsCounter() {
        let expectation = self.expectation(description: "wait for counter")
        
        var i = 0
        let sub = model.counter.sink { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(value, 0)
                self.fakeService.clockSubject.send(Date())
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
        model.isCounterStarted = false
        
        XCTAssertTrue(fakeService.clockWasStopped)
    }
    
    func testResetingCounterSetValueToZero() {
        let expectation = self.expectation(description: "wait for counter")
        
        var i = 0
        let sub = model.counter.sink { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(value, 0)
                self.model.resetCounter()
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
        let sub = model.counter.sink { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(value, 0)
                self.fakeService.clockSubject.send(Date())
            case 2:
                XCTAssertEqual(value, 1)
                self.fakeService.clockSubject.send(completion: .failure(.invalid))
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
