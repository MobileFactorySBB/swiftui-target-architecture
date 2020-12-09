//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class Model: ModelProtocol {
    
    var counter: AnyPublisher<Int, Never> {
        counterValue.eraseToAnyPublisher()
    }
    var isCounterStarted = false {
        didSet {
            if isCounterStarted {
                service.startClock()
            } else {
                service.stopClock()
            }
        }
    }
    
    private let service: ServiceProtocol
    private var counterValue = CurrentValueSubject<Int, Never>(0)
    private var clockSubscription: Cancellable!
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
        clockSubscription = service.clock.sink { completion in
            print("Clock completion: \(completion)")
            self.counterValue.value = 0
        } receiveValue: { _ in
            self.counterValue.value += 1
        }
    }
    
    func resetCounter() {
        counterValue.value = 0
    }
}
