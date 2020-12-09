//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import Combine
@testable import TargetArchitecture

class ViewModelTests: XCTestCase {
    
    private var viewModel: ViewModel!
    private var fakeModel: FakeModel!
    
    override func setUp() {
        fakeModel = FakeModel(isCounterStarted: false)
        viewModel = ViewModel(model: fakeModel)
    }
    
    func testViewModelInit() {
        XCTAssertEqual(viewModel.value, 0)
        XCTAssertFalse(viewModel.isCounterStarted)
    }
    
    func testModelCounterUpdatesValue() {
        let expectation = self.expectation(description: "wait for value update")
        
        var i = 0
        let sub = viewModel.$value.sink { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(value, 0)
                self.fakeModel.counterSubject.send(5)
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
    
    func testIsCounterStartedForwardsToModel() {
        viewModel.isCounterStarted = true
        
        XCTAssertTrue(fakeModel.isCounterStarted)
        viewModel.isCounterStarted = false
        
        XCTAssertFalse(fakeModel.isCounterStarted)
    }
    
    func testResetForwardsToModel() {
        viewModel.reset()
        
        XCTAssertTrue(fakeModel.resetWasCalled)
    }
}
