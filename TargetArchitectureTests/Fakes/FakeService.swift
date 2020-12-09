//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine
@testable import TargetArchitecture

class FakeService: ServiceProtocol {
    
    var clock: AnyPublisher<Date, ServiceError> {
        return valuesSubject.eraseToAnyPublisher()
    }
    
    let valuesSubject = PassthroughSubject<Date, ServiceError>()
    
    func startClock() {
        fatalError("not implemented")
    }
    
    func stopClock() {
        fatalError("not implemented")
    }
}
