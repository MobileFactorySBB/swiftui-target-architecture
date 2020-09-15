//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation

protocol MyViewModelProtocol: ObservableObject {
    
    var value: String { get set }
    var boolValue: Bool { get set }
    
    func myAction()
}
