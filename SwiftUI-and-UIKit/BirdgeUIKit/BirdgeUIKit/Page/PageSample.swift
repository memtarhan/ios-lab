//
//  PageSample.swift
//  BirdgeUIKit
//
//  Created by Mehmet Tarhan on 29/04/2023.
//

import SwiftUI

struct PageSample: View {
    var color: Color

    var body: some View {
        VStack {
            Image(systemName: "leaf.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .foregroundColor(color)
        }
    }
}

struct PageSample_Previews: PreviewProvider {
    static var previews: some View {
        PageSample(color: .accentColor)
    }
}
