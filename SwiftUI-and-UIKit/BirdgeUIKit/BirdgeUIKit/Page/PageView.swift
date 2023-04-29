//
//  PageView.swift
//  BirdgeUIKit
//
//  Created by Mehmet Tarhan on 29/04/2023.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]

    @State private var currentPage = 0

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(pages: pages, currentPage: $currentPage)
            
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: pages)
    }
}

let pages = [PageSample(color: .green), PageSample(color: .red), PageSample(color: .blue)]
