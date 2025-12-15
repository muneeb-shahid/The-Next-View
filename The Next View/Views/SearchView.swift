import SwiftUI

struct SearchView: View {
    @State private var searchByMovie = true
    @State private var searchText = ""
    @State private var navigationPath = NavigationPath()

    @State private var searchViewModel = SearchViewModel()
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                errorView
                searchResultsGrid
            }
            .navigationTitle(title)
            .toolbar { toolbarContent }
            .searchable(text: $searchText, prompt: placeholder)
            .task(id: searchText) { await performSearch() }
            .navigationDestination(for: Title.self) { title in
                TitleDetailView(title: title)
            }
        }
    }

    private var errorView: some View {
        Group {
            if let errorMessage = searchViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }

    private var searchResultsGrid: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(searchViewModel.searchTitles) { title in
                posterView(for: title)
            }
        }
        .padding()
    }

    private func posterView(for title: Title) -> some View {
        AsyncImage(url: URL(string: title.poster_path ?? "")) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(8)
        } placeholder: {
            ProgressView()
        }
        .frame(width: 120, height: 200)
        .onTapGesture {
            navigationPath.append(title)
        }
    }

    private var title: String {
        searchByMovie ? Constants.movieSearchString : Constants.tvSearchString
    }

    private var placeholder: String {
        searchByMovie
            ? Constants.moviePlaceHolderString : Constants.tvPlaceHolderString
    }

    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                searchByMovie.toggle()
                Task { await performSearch() }
            } label: {
                Image(
                    systemName: searchByMovie
                        ? ImageConstants.movieIcon : ImageConstants.tvIcon
                )
            }
        }
    }

    private func performSearch() async {
        do {
            try await Task.sleep(for: .milliseconds(500))
            guard !Task.isCancelled else { return }

            try await searchViewModel.fetchSearchTitles(
                by: searchByMovie ? Constants.movieString : Constants.tvString,
                for: searchText
            )
        } catch {
            print("Search error: \(error)")
        }
    }
}
