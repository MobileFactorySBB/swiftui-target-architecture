//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class FakeViewModel: ViewModelProtocol {
    
    @Published var value: String
    @Published var showValue: Bool
    
    init(value: String, showValue: Bool) {
        self.value = value
        self.showValue = showValue
    }
    
    func myAction() {
        self.value = "fakeAction"
    }
}
