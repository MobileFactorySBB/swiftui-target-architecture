//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct ContentView<Model: MyViewModelProtocol>: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        Text(model.value)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView<FakeViewModel>().environmentObject(FakeViewModel(value: "fake"))
    }
}
