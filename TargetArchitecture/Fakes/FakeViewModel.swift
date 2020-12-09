//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class FakeViewModel: ViewModelProtocol {
    
    @Published var value: String
    @Published var isTimerStarted: Bool
    
    init(value: String, isTimerStarted: Bool) {
        self.value = value
        self.isTimerStarted = isTimerStarted
    }
    
    func myAction() {
        self.value = "fakeAction"
    }
}
