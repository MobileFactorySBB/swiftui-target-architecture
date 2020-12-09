//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine
@testable import TargetArchitecture

class FakeService: ServiceProtocol {
    
    let clockSubject = PassthroughSubject<Date, ServiceError>()
    var clock: AnyPublisher<Date, ServiceError> {
        return clockSubject.eraseToAnyPublisher()
    }
    
    var clockWasStarted = false
    func startClock() {
        clockWasStarted = true
    }
    
    var clockWasStopped = false
    func stopClock() {
        clockWasStopped = true
    }
}
