//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class Service: ServiceProtocol {
    
    var clock: AnyPublisher<Date, ServiceError> {
        clockMulticaster.eraseToAnyPublisher()
    }
    private let clockMulticaster = PassthroughSubject<Date, ServiceError>()
    private var timerSubscription: Cancellable?
    
    func startClock() {
        timerSubscription = Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .setFailureType(to: ServiceError.self)
            .multicast(subject: clockMulticaster)
            .connect()
    }
    
    func stopClock() {
        timerSubscription?.cancel()
    }
}
