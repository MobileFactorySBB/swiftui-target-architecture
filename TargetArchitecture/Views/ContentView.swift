//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct ContentView<Model: ViewModelProtocol>: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        VStack(spacing: 8) {
            Toggle(isOn: $model.isCounterStarted) {
                Text("Start timer")
            }
            Text("Value: \(model.value)").accessibility(identifier: "counter_value")
            Button(action: model.reset) {
                Text("Reset")
            }
        }
        .padding(8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView<FakeViewModel>().environmentObject(FakeViewModel(value: 123, isCounterStarted: true))
                .previewDisplayName("ON 123")
            ContentView<FakeViewModel>().environmentObject(FakeViewModel(value: 456, isCounterStarted: false))
                .previewDisplayName("OFF 456")
        }
    }
}
