//
//  ViewController.swift
//  poc_viodeplayer
//
//  Created by Guilherme Domingues on 16/04/20.
//  Copyright © 2020 Guilherme Domingues. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class ViewController: UIViewController {

    @IBOutlet weak var player: WKYTPlayerView!
    
    var videos = ["R3MumdyHSJY",
                  "u5dIURdhdpk",
                  "97rwk9KPZwU",
                  "O7h2zBCcq5w",
                  "tXoe9Ebm0Io",
                  "j_UzB1A1MLA",
                  "rEQFsirQBJg",
                  "Mh1idv5as7s",
                  "6pAVnlN9DSM",
                  "bQYUFMOiFnM",
                  "q-HSgIJv-SQ",
                  "uAi2QnNf6oM"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        
        loadVideo(videos.first!)
    }
    
    fileprivate func loadVideo(_ videoId: String) {
        let playerVars: [String:Any] = [
            "autoplay": 1,
            "playsinline" : 1,
            "enablejsapi": 1,
            "wmode": "transparent",
            "controls": 0,
            "showinfo": 0,
            "rel": 0,
            "modestbranding": 1,
            "iv_load_policy": 3 //annotations
        ]
        player.load(withVideoId: videoId, playerVars: playerVars)
    }

}

extension ViewController: WKYTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        player.cuePlaylist(byVideos: videos, index: 0, startSeconds: 0, suggestedQuality: .auto)
    }
    
    func playerViewIframeAPIDidFailed(toLoad playerView: WKYTPlayerView) {
        player.nextVideo()
    }
    
    func playerView(_ playerView: WKYTPlayerView, receivedError error: WKYTPlayerError) {
        switch error {
        case .html5Error:
            print("html5Error")
        case .invalidParam:
            print("invalidParam")
        case .notEmbeddable:
            print("notEmbeddable")
        case .unknown:
            print("unknown")
        case .videoNotFound:
            print("videoNotFound")
        default:
            return
        }
        
        player.nextVideo()
    }
    
    func playerView(_ playerView: WKYTPlayerView, didChangeTo state: WKYTPlayerState) {
        switch state {
        case .playing:
            print("playing")
        case .queued:
            print("queued")
        default:
            return
        }
    }
    
}

