//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    
    var value: Int { get set }
    var isCounterStarted: Bool { get set }
    
    func reset()
}
