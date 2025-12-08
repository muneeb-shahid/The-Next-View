//
//  YoutubePlayer.swift
//  The Next View
//
//  Created by UTF LABS on 04/12/2025.
//

import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable {
   let webView = WKWebView()
   let videoId: String
   let youtubeBaseURL = APIConfig.shared?.youtubeBaseURL
   
   func makeUIView(context: Context) -> some UIView {
      return webView
   }
   
   func updateUIView(_ uiView: UIViewType, context: Context) {
       guard let baseURLString = youtubeBaseURL,
             let baseURL = URL(string: baseURLString) else {return}
       let fullURL = baseURL.appending(path: videoId)
       webView.load(URLRequest(url: fullURL))
   }
}

// struct YoutubePlayer: UIViewRepresentable {
//     var videoId: String
//     private let youtubeBaseURL = APIConfig.shared?.youtubeBaseURL
    
//     func makeUIView(context: Context) -> WKWebView {
//         let webView = WKWebView()
// //        webView.scrollView.isScrollEnabled = false
// //        webView.configuration.allowsInlineMediaPlayback = true
//         return webView
//     }
    
//     func updateUIView(_ uiView: WKWebView, context: Context) {
//         guard !videoId.isEmpty else {
//             print("⚠️ YoutubePlayer: videoId is empty, not loading")
//             return
//         }
        
//         // Use correct YouTube embed URL with www subdomain
//         let embedURLString = "https://www.youtube.com/embed/\(videoId)"
//         guard let embedURL = URL(string: embedURLString) else {
//             print("⚠️ YoutubePlayer: Failed to create embed URL")
//             return
//         }
        
//         print("🎥 YoutubePlayer loading URL: \(embedURL.absoluteString)")

//         if uiView.url?.absoluteString != embedURL.absoluteString {
//             uiView.load(URLRequest(url: embedURL))
//         }
//     }
// }
