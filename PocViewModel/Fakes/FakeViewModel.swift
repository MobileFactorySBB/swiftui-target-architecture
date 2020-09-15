//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class FakeViewModel: MyViewModelProtocol {
    
    var value: String
    var boolValue: Bool
    
    let objectWillChange = ObservableObjectPublisher()
    
    init(value: String, boolValue: Bool) {
        self.value = value
        self.boolValue = boolValue
    }
    
    func myAction() {
        print("fake action")
    }
}
