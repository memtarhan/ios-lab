//
//  ContentView.swift
//  Texts
//
//  Created by Mehmet Tarhan on 02/05/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 32) {
            Text("Hello, world!")
                .background(Color.yellow)

            Text("This is some longer text that is limited to three lines maximum, so anything more than that will cause the text to clip.")
                .lineLimit(3)
                .frame(width: 200)
                .background(Color.yellow)

            Text("This is some longer text that is limited to a specific range of lines, so anything more than six lines will cause the text to clip.")
                .lineLimit(3 ... 6)
                .frame(width: 200)
                .background(Color.yellow)

            // “f you need an exact line limit – meaning “this text should have exactly two lines of height, not more and not less”, you should use the reservesSpace parameter like this:”

            Text("This is always two lines")
                .lineLimit(2, reservesSpace: true)
                .background(Color.yellow)
            
            Text("The best laid plans")
                .foregroundStyle(.blue.gradient)
                .padding()
                .background(.yellow)
                .font(.headline)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
