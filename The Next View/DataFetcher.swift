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
    
    func fetchTitles(for media: String) async throws -> [Title] {
        
        guard let baseURL = tmdbBaseURL else {
            throw NetworkError.missingConfig
        }
        
        guard let apiKey = tmdbAPIKey else {
            throw NetworkError.missingConfig
        }
        
        print("Base Url: \(baseURL)")
        print("apiKey Url: \(apiKey)")
        
        guard let fetchTitlesUrl = URL(string: baseURL)?
                .appending(path: "3/trending/\(media)/day")
                .appending(queryItems: [
                    URLQueryItem(
                        name: "api_key",
                        value: apiKey
                    )
                ])
        else {
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
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles = try decoder.decode(APIObject.self, from: data).results
        print("titles in fetchTitles: \(titles.count)")
        Constants.addPosterPath(to: &titles)
        return titles
    }
    
}
