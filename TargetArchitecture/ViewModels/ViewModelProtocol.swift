//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    
    var value: String { get set }
    var showValue: Bool { get set }
    
    func myAction()
}
