//
//  ViewModel.swift
//  The Next View
//
//  Created by UTF LABS on 02/12/2025.
//

import Foundation

@Observable
class HomeViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(underlyingError: Error)
    }

    private(set) var homeStatus: FetchStatus = .notStarted
    private(set) var videoIdStatus: FetchStatus = .notStarted
    private(set) var upcomingStatus: FetchStatus = .notStarted

    private let dataFetcher = DataFetcher()
    var trendingMovies: [Title] = []
    var topRatedMovies: [Title] = []
    var upcomingMovies: [Title] = []

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
    
    
    
    func getUpcomingmovies() async {
        print("🎬 Starting to fetch upcoming movies...")
        upcomingStatus = .fetching
        
        do {
            async let upcomingMoviesValue  =  dataFetcher.fetchTitles(
                for: Constants.movieString,
                by: Constants.smallUpcomingString
            )
            
            upcomingMovies = try await upcomingMoviesValue
            print("✅ Successfully fetched \(upcomingMovies.count) upcoming movies")
            upcomingStatus = .success
        }
        catch {
            print("❌ Error fetching upcoming movies: \(error)")
            print("❌ Error details: \(error.localizedDescription)")
            upcomingStatus = .failed(underlyingError: error)
        }
        
    }

}
