//
//  PlaybackController.swift
//  Streaming
//
//  Created by Mehmet Tarhan on 28/02/2024.
//

import AVFoundation
import UIKit

class PlaybackController {
    weak var videoItemDelegate: PlayerViewControllerCoordinatorDelegate?
    let video = Video.sample
    private var playbackItems = [Video: PlayerViewControllerCoordinator]()

    func prepareForPlayback() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            print(error)
        }
    }

    private func coordinatorOrNil(for indexPath: IndexPath) -> PlayerViewControllerCoordinator? {
        return playbackItems[video]
    }

    func coordinator(video: Video) -> PlayerViewControllerCoordinator {
        if let playbackItem = playbackItems[video] {
            return playbackItem
        } else {
            let playbackItem = PlayerViewControllerCoordinator(video: video)
            playbackItem.delegate = videoItemDelegate
            playbackItems[video] = playbackItem
            return playbackItem
        }
    }

    func present(video: Video, from presentingViewController: UIViewController) {
        coordinator(video: video).presentFullScreen(from: presentingViewController)
    }

    func removeAllEmbeddedViewControllers() {
//        playbackItems.forEach {
//            $0.value.removeFromParentIfNeeded()
//        }
    }

    func dismissActivePlayerViewController(animated: Bool, completion: @escaping () -> Void) {
        let fullScreenItems = playbackItems
            .filter { $0.value.status.contains(.fullScreenActive) }
            .map { $0.value }
        if let fullScreenItem = fullScreenItems.first {
            fullScreenItem.dismiss(completion: completion)
        } else {
            completion()
        }
    }
}
