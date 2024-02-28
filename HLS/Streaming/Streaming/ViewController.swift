//
//  ViewController.swift
//  Streaming
//
//  Created by Mehmet Tarhan on 28/02/2024.
//

import UIKit

class ViewController: UIViewController {
    let playbackController = PlaybackController()

    override func viewDidLoad() {
        super.viewDidLoad()

        playbackController.prepareForPlayback()
        playbackController.videoItemDelegate = self
    }

    @IBAction func play(_ sender: Any) {
        playbackController.present(video: Video.sample, from: self)
    }
}

extension ViewController: PlayerViewControllerCoordinatorDelegate {
    func playerViewControllerCoordinator(_ coordinator: PlayerViewControllerCoordinator, restoreUIForPIPStop completion: @escaping (Bool) -> Void) {
//        if coordinator.playerViewControllerIfLoaded?.parent == nil {
//            playbackController.dismissActivePlayerViewController(animated: false) {
//                if let navigationController = self.navigationController {
//                    coordinator.restoreFullScreen(from: navigationController) {
//                        completion(true)
//                    }
//                } else {
//                    completion(false)
//                }
//            }
//        } else {
//            completion(true)
//        }
    }

    func playerViewControllerCoordinatorWillDismiss(_ coordinator: PlayerViewControllerCoordinator) {
//        if let indexPath = playbackController.indexPath(for: coordinator),
//           let contentBrowser = navigationController?.topViewController as? VideoBrowserViewController,
//           !contentBrowser.collectionView.fullyShowsItem(at: indexPath) {
//            contentBrowser.collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
//        }
    }
}
