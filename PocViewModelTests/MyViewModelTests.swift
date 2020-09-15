//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import Combine
@testable import PocViewModel

class MyViewModelTests: XCTestCase {
    
    private var viewModel: MyViewModel!
    private var fakeModel: MyFakeModel!

    override func setUp() {
        fakeModel = MyFakeModel()
        viewModel = MyViewModel(model: fakeModel)
    }

    func testMyViewModel() {
        let expectation = self.expectation(description: "wait...")
        
        var i = 0
        let sub = viewModel.$value.sink { value in
            i += 1
            switch i {
            case 1:
                XCTAssertEqual(value, "")
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
