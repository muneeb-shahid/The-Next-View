//
//  ApiConfig.swift
//  The Next View
//
//  Created by UTF LABS on 25/11/2025.
//

import Foundation

struct APIConfig: Decodable {
    let tmdbBaseURL: String
    let tmdbAPIKey: String
    let youtubeBaseURL: String
    let youtubeAPIKey: String
    let youtubeSearchURL: String

    static let shared: APIConfig? = {
        do {
            return try loadConfig()
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }()

    private static func loadConfig() throws -> APIConfig {
        guard
            let url = Bundle.main.url(
                forResource: "APIConfig",
                withExtension: "json"
            )
        else {
            throw APIConfigError.fileNotFound
        }

        do {
            let data = try Data(contentsOf: url)  // its read a file in bytes
            return try JSONDecoder().decode(APIConfig.self, from: data)

        } catch let error as DecodingError {
            throw APIConfigError.decordingFailed(underlyingError: error)
        } catch let error {
            throw APIConfigError.dataLoadingFailed(underlyingError: error)
        }

    }

}
