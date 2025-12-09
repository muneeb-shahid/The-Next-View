//
//  SearchView.swift
//  The Next View
//
//  Created by UTF LABS on 09/12/2025.
//

import SwiftUI

struct SearchView: View {
    var titles = Title.previewTitles
    @State private var searchByMovie = true
    @State private var searchText = ""
    private var searchViewModel = SearchViewModel()
    var body: some View {

        NavigationStack {
            ScrollView {

                if let errorMessage = searchViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red).padding().background(
                            .ultraThinMaterial
                        ).cornerRadius(10)
                }

                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(searchViewModel.searchTitles) { title in

                        AsyncImage(url: URL(string: title.poster_path ?? "")) {
                            image in
                            image.resizable().scaledToFit().cornerRadius(8)

                        } placeholder: {
                            ProgressView()
                        }

                        .frame(width: 120, height: 200)

                    }
                }
            }.navigationTitle(
                searchByMovie
                    ? Constants.movieSearchString : Constants.tvSearchString
            )

            .toolbar {
                ToolbarItem(placement: .topBarTrailing, ) {
                    Button {
                        searchByMovie.toggle()

                        Task {
                            try await searchViewModel.fetchSearchTitles(
                                by: searchByMovie
                                    ? Constants.movieString
                                    : Constants.tvString,
                                for: searchText
                            )
                        }
                    } label: {
                        Image(
                            systemName: searchByMovie
                                ? ImageConstants.movieIcon
                                : ImageConstants.tvIcon
                        )
                    }
                }
            }
            .searchable(
                text: $searchText,
                prompt: searchByMovie
                    ? Constants.moviePlaceHolderString
                    : Constants.tvPlaceHolderString
            )

            .task(id: searchText) {
                // Yahan try/throws nahi chalega → isliye Task banao
                Task {
                    do {
                        try await Task.sleep(for: .milliseconds(500))
                        print("There is an delay")
                        if Task.isCancelled { return }

                        try await searchViewModel.fetchSearchTitles(
                            by: searchByMovie
                                ? Constants.movieString : Constants.tvString,
                            for: searchText
                        )
                    } catch {
                        print("Search cancelled or error: \(error)")
                    }
                }
            }
        }
    }
}
//
//#Preview {
//    SearchView()
//}
