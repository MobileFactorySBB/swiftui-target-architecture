//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine
@testable import TargetArchitecture

class FakeModel: ModelProtocol {
    
    let counterSubject = PassthroughSubject<Int, Never>()
    var counter: AnyPublisher<Int, Never> {
        counterSubject.eraseToAnyPublisher()
    }
    
    var isCounterStarted: Bool
    var resetWasCalled = false
    
    init(isCounterStarted: Bool) {
        self.isCounterStarted = isCounterStarted
    }
    
    func resetCounter() {
        resetWasCalled = true
    }
}
