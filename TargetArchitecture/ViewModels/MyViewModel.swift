//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class MyViewModel: MyViewModelProtocol {
    
    @Published var value: String = ""
    @Published var boolValue: Bool = false
    
    private var sub: Cancellable!
    
    init(model: MyModelProtocol = MyModel()) {
        sub = model.values.receive(on: RunLoop.main).assign(to: \.value, on: self)
    }
    
    func myAction() {
        print("action")
    }
}
