//
//  ARViewController.swift
//  ARKitSwiftUI
//
//  Created by Mehmet Tarhan on 29/04/2023.
//

import ARKit
import UIKit

protocol ARViewControllerDelegate: AnyObject {
    func arViewControllerDidLoad()
    func arViewControllerDidAppear()
}

class ARViewController: UIViewController {
    private lazy var sceneView: ARSCNView = {
        let sceneView = ARSCNView()

        // Enable environment-based lighting
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true

        // Create a new scene
        let scene = SCNScene()

        // Set the scene to the view
        sceneView.scene = scene

        return sceneView
    }()

    var delegate: ARViewControllerDelegate?

    override func loadView() {
        super.loadView()

        view = sceneView

        sceneView.delegate = self

        // Create a new scene
        let scene = SCNScene()

        // Set the scene to the view
        sceneView.scene = scene
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.arViewControllerDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)

        delegate?.arViewControllerDidAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }
}

// MARK: - ARSCNViewDelegate

extension ARViewController: ARSCNViewDelegate { }
