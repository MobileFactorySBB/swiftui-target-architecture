//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

protocol ServiceProtocol {
    
    var values: AnyPublisher<Date, Never> { get }
}
