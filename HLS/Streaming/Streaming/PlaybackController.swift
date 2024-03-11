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
    private let videos: [Video]
    private var playbackItems = [Video: PlayerViewControllerCoordinator]()

    init(videos: [Video]) {
        self.videos = videos
    }

    func prepareForPlayback() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            print(error)
        }
    }

    func coordinator(for indexPath: IndexPath) -> PlayerViewControllerCoordinator {
        let video = videos[indexPath.row]
        if let playbackItem = playbackItems[video] {
            return playbackItem
        } else {
            let playbackItem = PlayerViewControllerCoordinator(video: video)
            playbackItem.delegate = videoItemDelegate
            playbackItems[video] = playbackItem
            return playbackItem
        }
    }

    func indexPath(for coordinator: PlayerViewControllerCoordinator) -> IndexPath? {
        if let index = videos.firstIndex(of: coordinator.video) {
            return IndexPath(item: index, section: 0)
        }
        return nil
    }

    func present(contentForIndexPath indexPath: IndexPath, from presentingViewController: UIViewController) {
        coordinator(for: indexPath).presentFullScreen(from: presentingViewController)
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
