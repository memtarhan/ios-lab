//
//  ARContainerView.swift
//  ARKitSwiftUI
//
//  Created by Mehmet Tarhan on 29/04/2023.
//

import SwiftUI

struct ARContainerView<ARView: View>: View {
    var view: ARView

    @State var arStates: [String] = []

    var body: some View {
        VStack {
            ARViewControllerRepresentable(view: view, arStates: $arStates)
                .frame(height: 400)
                .overlay {
                    TextOverlay(text: "Powered by ARKit")
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))

            Spacer()

            List {
                ForEach(arStates, id: \.self) { state in
                    Text(state)
                        .font(.headline)
                }
            }
        }
    }
}

struct TextOverlay: View {
    var text: String

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(text)
                    .font(.subheadline)
                    .bold()
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct ARContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ARContainerView(view: ARView())
    }
}
