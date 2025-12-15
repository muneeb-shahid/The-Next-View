//
//  Error.swift
//  The Next View
//
//  Created by UTF LABS on 28/11/2025.
//

import Foundation

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLoadingFailed(underlyingError: Error)
    case decordingFailed(underlyingError: Error)

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "API Configuration File not found."
        case .dataLoadingFailed(underlyingError: let error):
            return
                "Failed to load data from API Configuration File. Error: \(error.localizedDescription)"
        case .decordingFailed(underlyingError: let error):
            return
                "Failed to decode API Configuration. Error: \(error.localizedDescription)"

        }
    }
}

enum NetworkError: Error, LocalizedError {
    case missingConfig
    case badURLResponse(underlyingError: Error)
    case urlBuildFailed

    var errorDescription: String? {
        switch self {
        case .missingConfig:
            return "Missing API configuration."

        case .badURLResponse(let underlyingError):
            return
                "Bad URL Response. Error: \(underlyingError.localizedDescription)"
        case .urlBuildFailed:
            return "Failed to build URL."
        }
    }

}
