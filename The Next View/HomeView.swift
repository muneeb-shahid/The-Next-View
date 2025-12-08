//
//  HomeView.swift
//  The Next View
//
//  Created by UTF LABS on 24/11/2025.
//

import SwiftUI

struct HomeView: View {

    private var viewModel = ViewModel()
    @State private var titleDetailNavigationPath = NavigationPath()
    var body: some View {
        NavigationStack(path: $titleDetailNavigationPath) {
            GeometryReader { geo in
                ScrollView {
                    switch viewModel.homeStatus {
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(
                                width: geo.size.width,
                                height: geo.size.height
                            )
                    case .success:
                        LazyVStack {
                            AsyncImage(
                                url: URL(
                                    string: viewModel.heroTitle.poster_path
                                        ?? ""
                                )
                            ) {
                                image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .overlay {
                                        LinearGradient(
                                            stops: [
                                                Gradient.Stop(
                                                    color: .clear,
                                                    location: 0.8
                                                ),
                                                Gradient.Stop(
                                                    color: .gradient,
                                                    location: 1
                                                ),
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )

                                    }
                            } placeholder: {
                                ProgressView()
                            }

                            .frame(
                                width: geo.size.width,
                                height: geo.size.height * 0.85,
                            )
                            HStack {
                                Button {
                                    titleDetailNavigationPath.append(
                                        viewModel.heroTitle
                                    )
                                } label: {
                                    Text(Constants.playString)
                                        .buttonUI()

                                }
                                .frame(width: 150)
                                Button {

                                } label: {
                                    Text(Constants.downloadString)
                                        .buttonUI()
                                }

                            }
                            HorizontalListView(
                                headerText: Constants.trendingMovieString,
                                titles: viewModel.trendingMovies,
                                onTap: { title in
                                    
                                    print("Trending Movie Tapped: \(title)")

                                    titleDetailNavigationPath.append(
                                        title
                                    )
                                }
                            )
                            HorizontalListView(
                                headerText: Constants.topRatedMovieString,
                                titles: viewModel.topRatedMovies,
                                onTap: { title in
                                    titleDetailNavigationPath.append(
                                        title                                    )
                                    
                                    print("Top Rated Movie Tapped: \(title)")
                                }
                            )
                            HorizontalListView(
                                headerText: Constants.trendingTVString,
                                titles: viewModel.trendingTV,
                                onTap: { title in
                                    titleDetailNavigationPath.append(
                                        title                                    )
                                    
                                    
                                    print("Trending TV Tapped: \(title)")
                                }
                            )
                            HorizontalListView(
                                headerText: Constants.topRatedTVString,
                                titles: viewModel.topRatedTV,
                                onTap: { title in
                                    titleDetailNavigationPath.append(
                                        title
                                    )
                                    
                                    print("Top Rated TV Tapped: \(title)")
                                }

                            )

                        }
                    case .failed(let error):
                        Text(error.localizedDescription)
                            //                    errorMessage()
                            .frame(
                                width: geo.size.width,
                                height: geo.size.height
                            )

                    }

                }
            }.onAppear {
                print("...onAppear function...")
                //
                //            if let config = APIConfig.shared {
                //                print(config.tmdbAPIKey)
                //                print(config.tmdbBaseURL)
                //            }

            }.task {
                print("...on task function...")
                await viewModel.getTitles()
            }.onDisappear {
                print("...on DisAppear function...")
            }
            .navigationDestination(for: Title.self, ) {
                title in
                TitleDetailView(title: title)
            }
        }

    }
}

#Preview {
    HomeView()
}
