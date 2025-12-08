//
//  DataFetcher.swift
//  The Next View
//
//  Created by UTF LABS on 29/11/2025.
//

import Foundation

struct DataFetcher{
    
    let tmdbBaseURL = APIConfig.shared?.tmdbBaseURL
    let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey
    let youtubeBaseURL = APIConfig.shared?.youtubeBaseURL
    let youtubeAPIKey = APIConfig.shared?.youtubeAPIKey
    let youtubeSearchURL = APIConfig.shared?.youtubeSearchURL
    
    func fetchTitles(for media: String,  by type:String) async throws -> [Title] {
        
        
        let fetchTitlesUrl = try  helperBuildUrl(media: media , type: type, )
        guard let fetchTitlesUrl = fetchTitlesUrl else{
            throw NetworkError.urlBuildFailed
        }
        print("fetchTitlesUrl: \(fetchTitlesUrl)")
        
        let (data, urlResponse) = try await URLSession.shared.data(
            from: fetchTitlesUrl
        )
        
        guard let response = urlResponse as? HTTPURLResponse,
              response.statusCode == 200
        else {
            throw NetworkError.badURLResponse(
                underlyingError: NSError(
                    domain: "DataFetchers",
                    code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                    
                    userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"]
                    
                )
            )
        }
        
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles = try decoder.decode(APIObject.self, from: data).results
        print("titles in fetchTitles: \(titles.count)")
        Constants.addPosterPath(to: &titles)
        return titles
    }
    //https://www.googleapis.com/youtube/v3/search?q=Breaking%20Bad%20trailer&key=APIKEY
    func fetchVideoId(for title: String) async throws -> String {
        guard let baseSearchURL = youtubeSearchURL else {
            throw NetworkError.missingConfig
        }
        
        guard let searchAPIKey = youtubeAPIKey else {
            throw NetworkError.missingConfig
        }
        
        let trailerSearch = title + YoutubeURLStrings.space.rawValue + YoutubeURLStrings.trailer.rawValue
        
        guard let fetchVideoURL = URL(string: baseSearchURL)?.appending(queryItems: [
            URLQueryItem(name: YoutubeURLStrings.queryShorten.rawValue, value: trailerSearch),
            URLQueryItem(name: YoutubeURLStrings.key.rawValue, value: searchAPIKey)
        ]) else {
            throw NetworkError.urlBuildFailed
        }
        
        print("fetchVideoId URL:" , fetchVideoURL)
        
        return try await fetchAndDecode(url: fetchVideoURL, type: YoutubeSearchResponse.self).items?.first?.id.videoId ?? ""
//        guard let videoId = try await fetchAndDecode(url: fetchVideoURL, type: YoutubeSearchResponse.self).items?.first?.id.videoId else {
//            throw NetworkError.urlBuildFailed        }
//        return videoId
    }
    
    func fetchAndDecode<T: Decodable>(url: URL, type: T.Type) async throws -> T {
        let(data,urlResponse) = try await URLSession.shared.data(from: url)
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badURLResponse(underlyingError: NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"]))
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type, from: data)
    }
    
    private func helperBuildUrl(media:String,type:String) throws -> URL? {
        guard let baseURL = tmdbBaseURL else {
            throw NetworkError.missingConfig
        }
        
        guard let apiKey = tmdbAPIKey else {
            throw NetworkError.missingConfig
        }
        print("Base Url: \(baseURL)")
        print("apiKey Url: \(apiKey)")
        
        var path:String
              
              if type == "trending" {
                  path = "3/\(type)/\(media)/day"
              } else if type == "top_rated" || type == "upcoming" {
                  path = "3/\(media)/\(type)"
              } else if type == "search" {
                  path = "3/\(type)/\(media)"
              } else {
                  throw NetworkError.urlBuildFailed
              }
              
        let query = [
            URLQueryItem(
                name: "api_key",
                value: apiKey
            )
        ]
//        if let query {
//                    urlQueryItems.append(URLQueryItem(name: "query", value: searchPhrase))
//                }
        
        guard let url = URL(string: baseURL)?
                .appending(path: path)
                .appending(queryItems: query)
        else {
            throw NetworkError.urlBuildFailed
        }
        
        return url
    }
}
