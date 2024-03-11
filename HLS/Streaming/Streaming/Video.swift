//
//  Video.swift
//  Streaming
//
//  Created by Mehmet Tarhan on 28/02/2024.
//

import AVFoundation

struct Video: Hashable {
    let hlsUrl: URL
    var resumeTime: TimeInterval

    init(hlsUrl: URL, resumeTime: TimeInterval = 0) {
        self.hlsUrl = hlsUrl
        self.resumeTime = resumeTime
    }

    static let sample = Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2018/103zvtnsrnrijr/103/hls_vod_mvp.m3u8")!)
}

extension Video {
    static func makeVideos() -> [Video] {
        return [
            Video(hlsUrl: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
            Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2018/225s90wcvt1fjg6b/225/hls_vod_mvp.m3u8")!),
            Video(hlsUrl: URL(string: "https://p-events-delivery.akamaized.net/18oijbasfvuhbfsdvoijhbsdfvljkb6/m3u8/hls_vod_mvp.m3u8")!),
            Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2018/803lpnlacvg2jsndx/803/hls_vod_mvp.m3u8")!),
            Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2018/805llmiw0zwkox4zhuc/805/hls_vod_mvp.m3u8")!),
            Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2018/102ly3xmvz1ssb1ill/102/hls_vod_mvp.m3u8")!),
            Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2018/507axjplrd0yjzixfz/507/hls_vod_mvp.m3u8")!),
            Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2018/808j4pqwu6uymymjq/808/hls_vod_mvp.m3u8")!),
            Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2018/208piymryv9im6/208/hls_vod_mvp.m3u8")!),
            Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2018/502plwzfxg5p7w4na/502/hls_vod_mvp.m3u8")!),
            Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2017/219okz4tp7uyw5n/219/hls_vod_mvp.m3u8")!),
            Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2017/515vy4sl7iu70/515/hls_vod_mvp.m3u8")!),
            Video(hlsUrl: URL(string: "https://p-events-delivery.akamaized.net/17qopibbefvoiuhbsefvbsefvopihb06/m3u8/hls_vod_mvp.m3u8")!),
            Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2017/102xyar2647hak3e/102/hls_vod_mvp.m3u8")!),
            Video(hlsUrl: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2017/251txgutnwpkc4740f/251/hls_vod_mvp.m3u8")!),
        ]
    }
}
