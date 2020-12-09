//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine
@testable import TargetArchitecture

class FakeService: ServiceProtocol {
    
    var values: AnyPublisher<Date, Never> {
        return valuesSubject.eraseToAnyPublisher()
    }
    
    let valuesSubject = PassthroughSubject<Date, Never>()
}
