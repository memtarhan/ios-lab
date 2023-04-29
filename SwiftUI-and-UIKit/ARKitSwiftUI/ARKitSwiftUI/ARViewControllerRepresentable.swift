//
//  ARViewControllerRepresentable.swift
//  ARKitSwiftUI
//
//  Created by Mehmet Tarhan on 29/04/2023.
//

import SwiftUI
import UIKit

struct ARViewControllerRepresentable<ARView: View>: UIViewControllerRepresentable {
    var view: ARView

    @Binding var arStates: [String]

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> ARViewController {
        let viewController = ARViewController()
        // Modify ARViewController here
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        uiViewController.loadView()
    }

    class Coordinator: NSObject, ARViewControllerDelegate {
        var parent: ARViewControllerRepresentable
        var controller: UIViewController

        init(_ arViewControllerRepresentable: ARViewControllerRepresentable) {
            parent = arViewControllerRepresentable
            controller = UIHostingController(rootView: parent.view)
        }

        // Should use DispatchQueue.main.async on SwiftUI? Not sure, but it works
        func arViewControllerDidLoad() {
            DispatchQueue.main.async {
                self.parent.arStates.append("didLoad")
            }
            print(#function)
        }

        func arViewControllerDidAppear() {
            DispatchQueue.main.async {
                self.parent.arStates.append("didAppear")
            }
            print(#function)
        }
    }
}
