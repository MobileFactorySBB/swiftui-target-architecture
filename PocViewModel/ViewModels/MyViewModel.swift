//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import Combine

class MyViewModel: ObservableObject {
    
    @Published var value: String = ""
    private var sub: Cancellable!
    
    init(model: MyModelProtocol = MyModel()) {
        sub = model.values.receive(on: RunLoop.main).assign(to: \.value, on: self)
    }
}
