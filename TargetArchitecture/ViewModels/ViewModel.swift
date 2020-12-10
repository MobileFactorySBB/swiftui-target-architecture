//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class ViewModel: ViewModelProtocol {
    
    @Published var value: Int = 0
    @Published var isCounterStarted: Bool = false
    
    private var model: ModelProtocol
    private var counterValueSubscription: Cancellable!
    private var counterStartedSubscription: Cancellable!
    
    init(model: ModelProtocol = Model()) {
        self.model = model
        counterValueSubscription = model.counter.receive(on: RunLoop.main).assign(to: \.value, on: self)
        counterStartedSubscription = $isCounterStarted.sink(receiveValue: { self.model.isCounterStarted = $0 })
    }
    
    func reset() {
        model.resetCounter()
    }
}
