//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class Model: ModelProtocol {
    
    let values: AnyPublisher<String, Never>
        
    init(service: ServiceProtocol = Service()) {
        values = service.values.map({ $0.description }).eraseToAnyPublisher()
    }
}
