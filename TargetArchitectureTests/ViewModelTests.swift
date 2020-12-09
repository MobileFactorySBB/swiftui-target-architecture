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
        fakeModel = FakeModel()
        viewModel = ViewModel(model: fakeModel)
    }
    
    func testViewModel() {
        let expectation = self.expectation(description: "wait...")
        
        var i = 0
        let sub = viewModel.$value.sink { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(value, "Stopped")
                self.fakeModel.valuesSubject.send("test")
            case 2:
                XCTAssertEqual(value, "test")
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
