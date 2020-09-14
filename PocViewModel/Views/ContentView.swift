//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: MyViewModel
    
    var body: some View {
        Text(model.value)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(MyViewModel())
    }
}
