//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import Combine
@testable import TargetArchitecture

class ViewModelTests: XCTestCase {
    
    private var viewModel: ViewModel!
    private var fakeCounter: FakeCounter!
    
    override func setUp() {
        fakeCounter = FakeCounter(isCounterStarted: false)
        viewModel = ViewModel(model: fakeCounter)
    }
    
    func testViewModelInit() {
        XCTAssertEqual(viewModel.value, 0)
        XCTAssertFalse(viewModel.isCounterStarted)
    }
    
    func testCounterModelUpdatesValue() {
        let expectation = self.expectation(description: "wait for value update")
        
        var i = 0
        let sub = viewModel.$value.sink { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(value, 0)
                self.fakeCounter.counterSubject.send(5)
            case 2:
                XCTAssertEqual(value, 5)
                expectation.fulfill()
            default:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5.0) { _ in
            sub.cancel()
        }
    }
    
    func testIsCounterStartedForwardsToCounterModel() {
        viewModel.isCounterStarted = true
        
        XCTAssertTrue(fakeCounter.isCounterStarted)
        viewModel.isCounterStarted = false
        
        XCTAssertFalse(fakeCounter.isCounterStarted)
    }
    
    func testResetForwardsToCounterModel() {
        viewModel.reset()
        
        XCTAssertTrue(fakeCounter.resetWasCalled)
    }
}
