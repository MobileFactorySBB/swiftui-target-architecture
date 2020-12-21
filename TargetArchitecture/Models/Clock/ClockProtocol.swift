//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

protocol ClockProtocol {
    
    var clock: AnyPublisher<Date, ClockError> { get }
    
    func startClock()
    func stopClock()
}
