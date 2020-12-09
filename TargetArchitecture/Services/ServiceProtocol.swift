//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

protocol ServiceProtocol {
    
    var clock: AnyPublisher<Date, ServiceError> { get }
    
    func startClock()
    func stopClock()
}
