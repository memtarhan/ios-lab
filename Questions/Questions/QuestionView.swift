//
//  QuestionView.swift
//  Questions
//
//  Created by Mehmet Tarhan on 15/02/2024.
//

import SwiftUI

struct Answer: Hashable {
    let id: Int
    let content: String
    let index: String
}

struct Question {
    let content: String
    let answers: [Answer]

    static let sample = Question(content: "What is the capital of Canada?", answers: [
        Answer(id: 1, content: "Toronto", index: "A"),
        Answer(id: 2, content: "Vancouver", index: "B"),
        Answer(id: 3, content: "Montreal", index: "C"),
        Answer(id: 4, content: "Ottawa", index: "D")])
}

struct QuestionView: View {
    var question: Question
    @State private var selectedIndex: String? = nil

    var body: some View {
        VStack(alignment: .leading) {
            Text(question.content)
                .font(.title2.bold())
                .padding()
            VStack {
                ForEach(question.answers, id: \.self) { answer in
                    HStack {
                        Text(answer.index)
                            .padding(12)
                            .background(selectedIndex == answer.index ? Color.green : Color.secondarySurface)
                            .clipShape(Circle())
                            .foregroundStyle(selectedIndex == answer.index ? Color.white : Color.primary)
                        Text(answer.content)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primarySurface)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .onTapGesture {
                        if selectedIndex == answer.index {
                            selectedIndex = nil

                        } else {
                            selectedIndex = answer.index
                        }
                    }
                }
            }
            .background(Color.clear)
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
        }
        .background(Color.secondarySurface)
    }
}

#Preview {
    QuestionView(question: Question.sample)
}
