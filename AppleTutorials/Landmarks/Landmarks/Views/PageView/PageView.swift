//
//  PageView.swift
//  Landmarks
//
//  Created by Mehmet Tarhan on 29/04/2023.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]

    @State private var currentPage = 0

    var body: some View {
        // Remember to use the $ syntax to create a binding to a value that is stored as state.
        PageViewController(pages: pages, currentPage: $currentPage)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: ModelData().features.map { FeatureCard(landmark: $0) })
            .aspectRatio(3 / 2, contentMode: .fit)
    }
}
