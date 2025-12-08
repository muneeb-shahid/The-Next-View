//
//  ViewModel.swift
//  The Next View
//
//  Created by UTF LABS on 02/12/2025.
//

import Foundation

@Observable
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(underlyingError: Error)
    }

    private(set) var homeStatus: FetchStatus = .notStarted
    private(set) var videoIdStatus: FetchStatus = .notStarted
    
    private let dataFetcher = DataFetcher()
    var trendingMovies: [Title] = []
    var topRatedMovies: [Title] = []

    var trendingTV: [Title] = []
    var topRatedTV: [Title] = []
    var videoId = ""

    var heroTitle = Title.previewTitles[0]

    func getTitles() async {
        homeStatus = .fetching
        
        if(trendingMovies.isEmpty){
            do {
                async let trendingMoviesValue =  dataFetcher.fetchTitles(
                    for: Constants.movieString,
                    by: Constants.trendingString
                )
                async let topRatedMoviesValue  =  dataFetcher.fetchTitles(
                    for: Constants.movieString,
                    by: Constants.topUnderScoreRatedString
                )
                
                async let trendingTVValue  =  dataFetcher.fetchTitles(
                    for: Constants.tvString,
                    by: Constants.trendingString
                )
                async let topRatedTVValue  =  dataFetcher.fetchTitles(
                    for: Constants.tvString,
                    by: Constants.topUnderScoreRatedString
                )
                
                trendingMovies = try await trendingMoviesValue
                topRatedMovies = try await topRatedMoviesValue
                
                trendingTV = try await trendingTVValue
                topRatedTV = try await topRatedTVValue
                
                
                if let title = trendingMovies.randomElement( ){
                    heroTitle = title
                }
                
                homeStatus = .success
            } catch {
                print(error)
                homeStatus = .failed(underlyingError: error)
            }
        }
        else{
            homeStatus = .success
        }
    }
    func getVideoId(for title: String) async {
            videoIdStatus = .fetching
            
            do {
                videoId = try await dataFetcher.fetchVideoId(for: title)
                print("✅ Fetched videoId: '\(videoId)'")
                videoIdStatus = .success
            } catch {
                print(error)
                videoIdStatus = .failed(underlyingError: error)
            }
        }

}
