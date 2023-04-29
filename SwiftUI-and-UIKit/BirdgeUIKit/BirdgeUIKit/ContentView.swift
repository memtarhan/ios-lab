//
//  ContentView.swift
//  BirdgeUIKit
//
//  Created by Mehmet Tarhan on 29/04/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            PageView(pages: pages)
                .aspectRatio(3 / 2, contentMode: .fit)
                .listRowInsets(EdgeInsets())
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
