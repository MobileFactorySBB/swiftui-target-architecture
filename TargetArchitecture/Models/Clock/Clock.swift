//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class Clock: ClockProtocol {
    
    var clock: AnyPublisher<Date, ClockError> {
        clockMulticaster.eraseToAnyPublisher()
    }
    private let clockMulticaster = PassthroughSubject<Date, ClockError>()
    private var timerSubscription: Cancellable?
    
    func startClock() {
        timerSubscription = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .setFailureType(to: ClockError.self)
            .multicast(subject: clockMulticaster)
            .connect()
    }
    
    func stopClock() {
        timerSubscription?.cancel()
    }
}
