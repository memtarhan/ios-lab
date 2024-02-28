//
//  Video.swift
//  Streaming
//
//  Created by Mehmet Tarhan on 28/02/2024.
//

import AVFoundation

struct Video: Hashable {
    let hlsUrl: URL
    let title: String
    let duration: TimeInterval
    var resumeTime: TimeInterval

    init(hlsUrl: URL, title: String, duration: TimeInterval, resumeTime: TimeInterval = 0) {
        self.hlsUrl = hlsUrl
        self.title = title
        self.duration = duration
        self.resumeTime = resumeTime
    }

    static let sample = Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2018/103zvtnsrnrijr/103/hls_vod_mvp.m3u8")!,
                              title: "Apple Design Awards",
                              duration: 2946)
}
