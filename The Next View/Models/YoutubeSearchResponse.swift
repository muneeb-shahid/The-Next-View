import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [itemProperties]?
}

struct itemProperties: Codable {
    let id: IdProperties
}

struct IdProperties: Codable {
    let kind: String?
    let videoId: String?
}
