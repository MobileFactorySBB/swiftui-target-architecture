//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class ViewModel: ViewModelProtocol {
    
    @Published var value: String = ""
    @Published var showValue: Bool = true
    
    private var sub: Cancellable!
    
    init(model: ModelProtocol = Model()) {
        sub = model.values.receive(on: RunLoop.main).assign(to: \.value, on: self)
    }
    
    func myAction() {
        print("action")
    }
}
