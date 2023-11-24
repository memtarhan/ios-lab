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
            Group {
                UsingText()
                Divider()
            }

            Group {
                AdvancedTextStyling()
                Divider()
            }

            Group {
                TextAlignmetStyling()
                Divider()
            }

            Group {
                TextFormatting()
                Divider()
            }

            Group {
                TextAndIcon()
                Divider()
            }

            Group {
                MarkdownText()
                Divider()
            }
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

struct TextFormatting: View {
    @State private var ingredients = [String]()
    @State private var rolls = [Int]()
    let lenght = Measurement(value: 190, unit: UnitLength.centimeters)
    @State private var name = "Paul"

    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text(ingredients, format: .list(type: .and))
                //            Text(ingredients, format: .list(type: .or))

                Button("Add Ingredients") {
                    let possibles = ["Egg", "Sausage", "Bacon", "Spam"]
                    if let newIngredient = possibles.randomElement() {
                        ingredients.append(newIngredient)
                    }
                }
            }

            VStack {
                Text(rolls, format: .list(memberStyle: .number, type: .and))

                Button("Roll Dice") {
                    let result = Int.random(in: 1 ... 6)
                    rolls.append(result)
                }
            }

            VStack {
                Text("Measurement")
                Text(lenght, format: .measurement(width: .wide))
            }

            VStack {
                Text("Currency")
                Text(72.3, format: .currency(code: "EUR"))
            }

            VStack {
                Text("iOS14 and iOS13 Formatting")
                iOS14_iOS13TextFormatting()
            }

            VStack {
                // show just the date
                Text(Date.now.addingTimeInterval(600), style: .date)

                // show just the time
                Text(Date.now.addingTimeInterval(600), style: .time)

                // show the relative distance from now, automatically updating
                Text(Date.now.addingTimeInterval(600), style: .relative)

                // make a timer style, automatically updating
                Text(Date.now.addingTimeInterval(600), style: .timer)
            }

            VStack {
                TextField("Shout your name at me", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .textCase(.uppercase)
                    .padding(.horizontal)
            }
        }
    }
}

struct iOS14_iOS13TextFormatting: View {
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    let dueDate = Date.now

    var body: some View {
        Text("Task due date: \(dueDate, formatter: Self.taskDateFormat)")
    }
}

struct TextAndIcon: View {
    var body: some View {
        VStack {
            Label("Your account", systemImage: "person.crop.circle")
                .font(.title)
            VStack {
                Label("Text Only", systemImage: "heart")
                    .font(.title)
                    .labelStyle(.titleOnly)
                Label("Icon Only", systemImage: "star")
                    .font(.title)
                    .labelStyle(.iconOnly)
                Label("Both", systemImage: "heart")
                    .font(.title)
                    .labelStyle(.titleAndIcon)
            }

            VStack {
                Label {
                    Text("Mehmet Tarhan")
                        .foregroundColor(.primary)
                        .font(.largeTitle)
                        .padding()
                        .background(.gray.opacity(0.2))
                        .clipShape(Capsule())

                } icon: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                        .frame(width: 64, height: 64)
                }
            }
        }
    }
}

struct MarkdownText: View {
    var body: some View {
        VStack {
            Text("This is regular text.")
            Text("* This is **bold** text, this is *italic* text, and this is ***bold, italic*** text.")
            Text("~~A strikethrough example~~")
            Text("`Monospaced works too`")
            Text("Visit Apple: [click here](https://apple.com)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
