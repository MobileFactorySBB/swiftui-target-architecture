//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class FakeViewModel: MyViewModelProtocol {
    
    // synthetize version
//    @Published var value: String
//    @Published var boolValue: Bool
    
    // manual version
    private var _value: String
    private var _boolValue: Bool
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
    var boolValue: Bool {
        get {
            return _boolValue
        }
        set {
            objectWillChange.send()
            _boolValue = newValue
        }
    }
    
    init(value: String, boolValue: Bool) {
        _value = value
        _boolValue = boolValue
        self.value = value
        self.boolValue = boolValue
    }
    
    func myAction() {
        self.value = "fakeAction"
    }
}
