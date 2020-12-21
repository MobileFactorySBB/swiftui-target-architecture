//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine
@testable import TargetArchitecture

class FakeClock: ClockProtocol {
    
    let clockSubject = PassthroughSubject<Date, ClockError>()
    var clock: AnyPublisher<Date, ClockError> {
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
