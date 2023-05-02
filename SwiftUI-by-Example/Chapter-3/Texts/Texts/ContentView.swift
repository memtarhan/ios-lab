//
//  ContentView.swift
//  Texts
//
//  Created by Mehmet Tarhan on 02/05/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            UsingText()
            Divider()
            AdvancedTextStyling()
            Divider()
            TextAlignmetStyling()
        }
    }
}

struct UsingText: View {
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

struct AdvancedTextStyling: View {
    var message1: AttributedString {
        var result = AttributedString("Hello")
        result.font = .largeTitle
        result.foregroundColor = .white
        result.backgroundColor = .red
        return result
    }

    var message2: AttributedString {
        var result = AttributedString("World")
        result.font = .largeTitle
        result.foregroundColor = .white
        result.backgroundColor = .green
        return result
    }

    var message3: AttributedString {
        var result = AttributedString("Heyyy")
        result.font = .largeTitle
        result.foregroundColor = .white
        result.backgroundColor = .blue
        result.underlineStyle = Text.LineStyle(pattern: .solid, color: .white)
        return result
    }

    var body: some View {
        VStack {
            Text(message1 + message2)
            Text(message3)
        }
    }
}

struct TextAlignmetStyling: View {
    let alignments: [TextAlignment] = [.leading, .center, .trailing]
    @State private var alignment = TextAlignment.leading

    var body: some View {
        VStack {
            Picker("Text alignment", selection: $alignment) {
                ForEach(alignments, id: \.self) { alignment in
                    Text(String(describing: alignment))
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Text("This is an extremely long text string that will never fit even the widest of phones without wrapping")
                .font(.largeTitle)
                .multilineTextAlignment(alignment)
                .frame(width: 300)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
