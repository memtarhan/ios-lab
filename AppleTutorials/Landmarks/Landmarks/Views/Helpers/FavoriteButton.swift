//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by Mehmet Tarhan on 28/04/2023.
//

import SwiftUI

struct FavoriteButton: View {
    // Because you use a binding, changes made inside this view propagate back to the data source.
    @Binding var isSet: Bool

    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
