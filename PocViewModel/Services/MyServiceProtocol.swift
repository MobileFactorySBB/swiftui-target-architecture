//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

protocol MyServiceProtocol {
    
    var values: AnyPublisher<Date, Never> { get }
}
