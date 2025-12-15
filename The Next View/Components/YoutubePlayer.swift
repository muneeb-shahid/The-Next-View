//
//  YoutubePlayer.swift
//  The Next View
//
//  Created by UTF LABS on 04/12/2025.
//

import SwiftUI
import YouTubePlayerKit

struct YoutubePlayer: View {
    let videoId: String
    
    var body: some View {
        YouTubePlayerView(
            YouTubePlayer(
                source: .video(id: videoId),
                configuration: .init(
//                    autoPlay: false,
//                    showControls: true,
//                    playInline: true
                )
            )
        )
    }
}


