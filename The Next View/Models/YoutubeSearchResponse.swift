//
//  YoutubeSearchResponse.swift
//  The Next View
//
//  Created by UTF LABS on 05/12/2025.
//

import Foundation


struct YoutubeSearchResponse: Codable {
    let items: [itemProperties]?
}

struct itemProperties: Codable {
    let id: IdProperties
}

// struct IdProperties: Codable {
//     let videoId: String
// }

struct IdProperties: Codable {
    let kind: String?
    let videoId: String?
}
