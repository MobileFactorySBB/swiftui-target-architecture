//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class ViewModel: ViewModelProtocol {
    
    @Published var value: String = "Stopped"
    @Published var isTimerStarted: Bool = false
    
    private var sub: Cancellable!
    
    init(model: ModelProtocol = Model()) {
        sub = model.values.receive(on: RunLoop.main).assign(to: \.value, on: self)
    }
    
    func myAction() {
        print("action")
    }
}
