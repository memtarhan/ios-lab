//
//  ContentView.swift
//  ARKitSwiftUI
//
//  Created by Mehmet Tarhan on 29/04/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ARContainerView(view: ARView())
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
