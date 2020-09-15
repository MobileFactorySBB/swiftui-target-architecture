//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class FakeViewModel: MyViewModelProtocol {
    
    var value: String
    
    let objectWillChange = ObservableObjectPublisher()
    
    init(value: String) {
        self.value = value
    }
}
