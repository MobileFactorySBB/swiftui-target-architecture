//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class FakeViewModel: ViewModelProtocol {
    
    // synthetize version
//    @Published var value: String
//    @Published var boolValue: Bool
    
    // manual version
    private var _value: String
    private var _showValue: Bool
    
    let objectWillChange = ObservableObjectPublisher()
    
    var value: String {
        get {
            return _value
        }
        set {
            objectWillChange.send()
            _value = newValue
        }
    }
    
    var showValue: Bool {
        get {
            return _showValue
        }
        set {
            objectWillChange.send()
            _showValue = newValue
        }
    }
    
    init(value: String, showValue: Bool) {
        _value = value
        _showValue = showValue
        self.value = value
        self.showValue = showValue
    }
    
    func myAction() {
        self.value = "fakeAction"
    }
}
