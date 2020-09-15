//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine
@testable import PocViewModel

class MyFakeModel: MyModelProtocol {
    
    var values: AnyPublisher<String, Never> {
        return valuesSubject.eraseToAnyPublisher()
    }
    let valuesSubject = PassthroughSubject<String, Never>()
    
}
