//
//  ViewController.swift
//  Streaming
//
//  Created by Mehmet Tarhan on 28/02/2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var playbackController: PlaybackController!

    @IBOutlet var tableView: UITableView!

    private let videos = Video.makeVideos()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.estimatedRowHeight = 120
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Video")
        cell?.textLabel?.text = "Video at \(indexPath.row)"
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playbackController = PlaybackController(videos: videos)
        playbackController.prepareForPlayback()
        playbackController.videoItemDelegate = self
        playbackController.present(contentForIndexPath: indexPath, from: self)
    }
}

extension ViewController: PlayerViewControllerCoordinatorDelegate {
    
    func playerViewControllerCoordinatorWillDismiss(_ coordinator: PlayerViewControllerCoordinator) {
        if let indexPath = playbackController.indexPath(for: coordinator),
            let contentBrowser = navigationController?.topViewController as? ViewController {
            contentBrowser.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}
