//
//  PlayerViewControllerCoordinator.swift
//  Streaming
//
//  Created by Mehmet Tarhan on 28/02/2024.
//

import AVKit

protocol PlayerViewControllerCoordinatorDelegate: AnyObject {
    func playerViewControllerCoordinator(
        _ coordinator: PlayerViewControllerCoordinator,
        restoreUIForPIPStop completion: @escaping (Bool) -> Void
    )

    func playerViewControllerCoordinatorWillDismiss(_ coordinator: PlayerViewControllerCoordinator)
}

class PlayerViewControllerCoordinator: NSObject {
    // MARK: - Initialization

    init(video: Video) {
        self.video = video
        super.init()
    }

    // MARK: - Properties

    weak var delegate: PlayerViewControllerCoordinatorDelegate?
    var video: Video

    private(set) var status: Status = [] {
        didSet {
            if oldValue.isBeingShown && !status.isBeingShown {
                playerViewControllerIfLoaded = nil
            }
        }
    }

    private(set) var playerViewControllerIfLoaded: AVPlayerViewController? {
        didSet {
            guard playerViewControllerIfLoaded != oldValue else { return }

            // 1) Invalidate the key value observer, delegate, player, and status for the original player view controller.

            readyForDisplayObservation?.invalidate()
            readyForDisplayObservation = nil

            if oldValue?.delegate === self {
                oldValue?.delegate = nil
            }

            if oldValue?.hasContent(fromVideo: video) == true {
                oldValue?.player = nil
            }

            status = []

            // 2) Set up the new playerViewController.

            if let playerViewController = playerViewControllerIfLoaded {
                // 2a) Assign self as the player view controller delegate.
                playerViewController.delegate = self

                // 2b) Create a player for the video.
                if !playerViewController.hasContent(fromVideo: video) {
                    let playerItem = AVPlayerItem(url: video.hlsUrl)
                    // Seek to the resume time *before* assigning the player to the view controller.
                    // This is more efficient, and provides a better user experience because the media only loads at the actual start time.
                    playerItem.seek(to: CMTime(seconds: video.resumeTime, preferredTimescale: 90000), completionHandler: nil)
                    playerViewController.player = AVPlayer(playerItem: playerItem)
                }

                // 2c) Update the player view contoller's ready-for-display status and start observing the property.
                if playerViewController.isReadyForDisplay {
                    status.insert(.readyForDisplay)
                }

                readyForDisplayObservation = playerViewController.observe(\.isReadyForDisplay) { [weak self] observed, _ in
                    if observed.isReadyForDisplay {
                        self?.status.insert(.readyForDisplay)
                    } else {
                        self?.status.remove(.readyForDisplay)
                    }
                }
            }
        }
    }

    // MARK: - Private vars

    private weak var fullScreenViewController: UIViewController?
    private var readyForDisplayObservation: NSKeyValueObservation?
}

// Utility functions for some common UIKit tasks that the coordinator manages.

extension PlayerViewControllerCoordinator {
    // Present full screen, and then start playback. There's no need to change the modal presentation style
    // or set the transitioning delegate. AVPlayerViewController handles that automatically.
    func presentFullScreen(from presentingViewController: UIViewController) {
        guard !status.contains(.fullScreenActive) else { return }
        loadPlayerViewControllerIfNeeded()
        guard let playerViewController = playerViewControllerIfLoaded else { return }
        presentingViewController.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }

    // Demonstrates how to restore the video playback interface when Picture in Picture stops.
    func restoreFullScreen(from presentingViewController: UIViewController, completion: @escaping () -> Void) {
        guard let playerViewController = playerViewControllerIfLoaded,
              status.contains(.pictureInPictureActive),
              !status.contains(.fullScreenActive)
        else {
            completion()
            return
        }
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = true
        playerViewController.view.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        presentingViewController.present(playerViewController, animated: true, completion: completion)
    }

    // Dismiss any active player view controllers before restoring the interface from Picture in Picture mode.
    // The AVPlayerViewController delegate methods show how to obtain the fullScreenViewController.
    func dismiss(completion: @escaping () -> Void) {
        fullScreenViewController?.dismiss(animated: true) {
            completion()
            self.status.remove(.fullScreenActive)
        }
    }
}

extension PlayerViewControllerCoordinator {
    // An OptionSet describing the various states the app tracks in the DebugHUD.
    struct Status: OptionSet, CustomDebugStringConvertible {
        let rawValue: Int

        static let fullScreenActive = Status(rawValue: 1 << 0)
        static let beingPresented = Status(rawValue: 1 << 1)
        static let beingDismissed = Status(rawValue: 1 << 2)
        static let pictureInPictureActive = Status(rawValue: 1 << 3)
        static let readyForDisplay = Status(rawValue: 1 << 4)

        static let descriptions: [(Status, String)] = [
            (.fullScreenActive, "Full Screen Active"),
            (.beingPresented, "Being Presented"),
            (.beingDismissed, "Being Dismissed"),
            (.pictureInPictureActive, "Picture In Picture Active"),
            (.readyForDisplay, "Ready For Display"),
        ]

        var isBeingShown: Bool {
            return !intersection([.pictureInPictureActive, .fullScreenActive]).isEmpty
        }

        var debugDescription: String {
            var debugDescriptions = Status.descriptions
                .filter { contains($0.0) }
                .map { $0.1 }
            if isEmpty {
                debugDescriptions.append("Idle (Tap to full screen)")
            } else if !contains(.readyForDisplay) {
                debugDescriptions.append("NOT Ready For Display")
            }
            return debugDescriptions.joined(separator: "\n")
        }
    }
}

extension PlayerViewControllerCoordinator: AVPlayerViewControllerDelegate {
    // 1a) Update the status when Picture in Picture playback is about to start.
    func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        status.insert(.pictureInPictureActive)
    }

    // 1b) Update the status when Picture in Picture playback fails to start.
    func playerViewController(_ playerViewController: AVPlayerViewController, failedToStartPictureInPictureWithError error: Error) {
        status.remove(.pictureInPictureActive)
    }

    // 1c) Update the status when Picture in Picture playback stops.
    func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
        status.remove(.pictureInPictureActive)
    }

    // 2a) Track the presentation of the player view controller's content.
    // Note that this may happen while the player view controller is embedded inline.
    func playerViewController(
        _ playerViewController: AVPlayerViewController,
        willBeginFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator
    ) {
        status.insert([.fullScreenActive, .beingPresented])

        coordinator.animate(alongsideTransition: nil) { context in
            self.status.remove(.beingPresented)
            // You need to check context.isCancelled to determine whether the transition succeeds.
            if context.isCancelled {
                self.status.remove(.fullScreenActive)
            } else {
                // Keep track of the view controller playing full screen.
                self.fullScreenViewController = context.viewController(forKey: .to)
            }
        }
    }

    // 2b) Track the player view controller's dismissal from full-screen playback. This is the mirror
    // image of the playerViewController(_:willBeginFullScreenPresentationWithAnimationCoordinator:) function.
    func playerViewController(
        _ playerViewController: AVPlayerViewController,
        willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator
    ) {
        status.insert([.beingDismissed])
        delegate?.playerViewControllerCoordinatorWillDismiss(self)

        coordinator.animate(alongsideTransition: nil) { context in
            self.status.remove(.beingDismissed)
            if !context.isCancelled {
                self.status.remove(.fullScreenActive)
            }
        }
    }

    // 3) The most important delegate method for Picture in Picture--restoring the user interface.
    // This implementation sends the callback to its own delegate view controller because the coordinator
    // doesn't have enough global context to perform the restore operation.
    func playerViewController(
        _ playerViewController: AVPlayerViewController,
        restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void
    ) {
        if let delegate = delegate {
            delegate.playerViewControllerCoordinator(self, restoreUIForPIPStop: completionHandler)
        } else {
            completionHandler(false)
        }
    }
}

extension PlayerViewControllerCoordinator {
    private func loadPlayerViewControllerIfNeeded() {
        if playerViewControllerIfLoaded == nil {
            playerViewControllerIfLoaded = AVPlayerViewController()
        }
    }
}

private extension AVPlayerViewController {
    func hasContent(fromVideo video: Video) -> Bool {
        let url = (player?.currentItem?.asset as? AVURLAsset)?.url
        return url == video.hlsUrl
    }
}
