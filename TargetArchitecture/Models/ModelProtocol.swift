//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

protocol ModelProtocol {
    
    var values: AnyPublisher<String, Never> { get }
}
