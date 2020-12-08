//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation

class Service: ServiceProtocol {
    
    let values = Timer.publish(every: 1.0, on: .main, in: .default).autoconnect().eraseToAnyPublisher()
}
