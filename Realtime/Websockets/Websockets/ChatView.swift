//
//  ContentView.swift
//  Websockets
//
//  Created by Mehmet Tarhan on 28/05/2023.
//

import SwiftUI

struct ChatView: View {
    @StateObject var model = ModelData()

    @State private var message: String = ""
    @FocusState private var messageIsFocused: Bool

    var body: some View {
        NavigationStack {
            ScrollViewReader { scrollView in

                VStack {
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(model.messages, id: \.self) { message in
                                ChatBubble(position: .left, color: .blue) {
                                    Text(message)
                                }
                            }
                            .padding([.trailing, .leading], 8)
                        }.id("ChatScrollView")
                    }
                    .onChange(of: model.messages) { _ in
                        withAnimation {
                            scrollView.scrollTo("ChatScrollView", anchor: .bottom)
                        }
                    }
                    Spacer()
                    HStack {
                        TextField("Type your message...", text: $message, axis: .vertical)
                            .padding(8)
                            .focused($messageIsFocused)

                        Button {
                            messageIsFocused = false
                            model.send(message: message)
                        } label: {
                            Image(systemName: "arrow.up.circle.fill")
                        }
                        .font(.title)
                        .padding(2)
                    }

                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.accentColor, lineWidth: 1)
                    )
                    .padding([.bottom, .leading, .trailing], 8)
                }
            }
            .navigationTitle("Channel 1")
        }
    }
}

var randomPosition: BubblePosition {
    let random = Int.random(in: 0 ... 1)
    if random == 0 {
        return .left
    }
    return .right
}

enum BubblePosition {
    case left
    case right
}

struct ChatBubble<Content>: View where Content: View {
    let position: BubblePosition
    let color: Color
    let content: () -> Content
    init(position: BubblePosition, color: Color, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.color = color
        self.position = position
    }

    var body: some View {
        HStack(spacing: 0) {
            content()
                .padding(.all, 15)
                .foregroundColor(Color.white)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .overlay(
                    Image(systemName: "arrowtriangle.left.fill")
                        .foregroundColor(color)
                        .rotationEffect(Angle(degrees: position == .left ? -50 : -130))
                        .offset(x: position == .left ? -5 : 5)
                    , alignment: position == .left ? .bottomLeading : .bottomTrailing)
        }
        .padding(position == .left ? .leading : .trailing, 15)
        .padding(position == .right ? .leading : .trailing, 60)
        .frame(width: UIScreen.main.bounds.width, alignment: position == .left ? .leading : .trailing)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
