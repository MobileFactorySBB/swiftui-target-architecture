//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

protocol ModelProtocol {
    
    var counter: AnyPublisher<Int, Never> { get }
    var isCounterStarted: Bool { get set }
    
    func resetCounter()
}
