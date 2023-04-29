//
//  PageViewController.swift
//  Landmarks
//
//  Created by Mehmet Tarhan on 29/04/2023.
//

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]

    // SwiftUI calls this method a single time when it’s ready to display the view, and then manages the view controller’s life cycle.
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)

        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [UIHostingController(rootView: pages[0])], direction: .forward, animated: true)
    }
}
