//
//  ContentView.swift
//  Questions
//
//  Created by Mehmet Tarhan on 15/02/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            QuestionView(question: Question.sample)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
