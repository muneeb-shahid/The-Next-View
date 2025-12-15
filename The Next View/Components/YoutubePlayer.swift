import SwiftUI
import YouTubePlayerKit

struct YoutubePlayer: View {
    let videoId: String

    var body: some View {
        YouTubePlayerView(
            YouTubePlayer(
                source: .video(id: videoId),
                configuration: .init(

                    )
            )
        )
    }
}
