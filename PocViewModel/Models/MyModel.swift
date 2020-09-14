//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class MyModel: MyModelProtocol {
    
    let values: AnyPublisher<String, Never>
    
    init(service: MyServiceProtocol = MyService()) {
        values = service.values.map({ $0.description }).eraseToAnyPublisher()
    }
}
