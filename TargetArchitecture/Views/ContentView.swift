//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct ContentView<Model: MyViewModelProtocol>: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        VStack {
            Text(model.value).accessibility(identifier: "my_text")
            Toggle(isOn: $model.boolValue) {
                Text("Toggle")
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
        ContentView<FakeViewModel>().environmentObject(FakeViewModel(value: "fake", boolValue: true))
    }
}
