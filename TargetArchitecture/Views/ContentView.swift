//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct ContentView<Model: ViewModelProtocol>: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        VStack(spacing: 8) {
            Toggle(isOn: $model.isTimerStarted) {
                Text("Start timer")
            }
            Text(model.value).accessibility(identifier: "timer_value")
            Button(action: model.myAction) {
                Text("Button")
            }
        }
        .padding(8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView<FakeViewModel>().environmentObject(FakeViewModel(value: "fake", isTimerStarted: true))
                .previewDisplayName("ON")
            ContentView<FakeViewModel>().environmentObject(FakeViewModel(value: "fake2", isTimerStarted: false))
                .previewDisplayName("OFF")
        }
    }
}
