//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct ContentView<Model: ViewModelProtocol>: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        VStack {
            Toggle(isOn: $model.showValue) {
                Text("Show current time")
            }
            if model.showValue {
                Text(model.value).accessibility(identifier: "my_text")
            }
            Button(action: model.myAction) {
                Text("Button")
            }
        }
        .padding(8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView<FakeViewModel>().environmentObject(FakeViewModel(value: "fake", showValue: true))
    }
}
