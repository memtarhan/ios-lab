//
//  PageViewController.swift
//  BirdgeUIKit
//
//  Created by Mehmet Tarhan on 29/04/2023.
//

import SwiftUI
import UIKit

// UIPageViewController in SwiftUI

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPage: Int

    // SwiftUI calls this makeCoordinator() method before makeUIViewController(context:), so that you have access to the coordinator object when configuring your view controller.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Return any UIViewController
    func makeUIViewController(context: Context) -> UIPageViewController {
        // Init View controller here
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
//        pageViewController.delegate = context.coordinator

        return pageViewController
    }

    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        uiViewController.setViewControllers([context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }

    /*
     A SwiftUI view that represents a UIKit view controller can define a Coordinator type that SwiftUI manages and provides as part of the representable view’s context.
     SwiftUI manages your UIViewControllerRepresentable type’s coordinator, and provides it as part of the context when calling the methods you created above.
     */
    class Coordinator: NSObject, UIPageViewControllerDataSource {
        var parent: PageViewController
        var controllers = [UIViewController]()

        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }

        // MARK: - Pagination logic - data source

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }
    }
}
