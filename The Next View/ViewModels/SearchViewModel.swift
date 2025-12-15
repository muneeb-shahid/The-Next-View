import Foundation

@Observable
class SearchViewModel {

    private(set) var errorMessage: String?

    private(set) var searchTitles: [Title] = []
    private let dataFetcher = DataFetcher()

    func fetchSearchTitles(by media: String, for title: String) async throws {

        do {

            errorMessage = nil
            if title.isEmpty {
                searchTitles = try await dataFetcher.fetchTitles(
                    for: media,
                    by: Constants.trendingString
                )
            } else {
                searchTitles = try await dataFetcher.fetchTitles(
                    for: media,
                    by: Constants.smallSearchString,
                    with: title
                )

            }

        } catch {
            print("search function error ----> ", error)
            errorMessage = error.localizedDescription
        }
    }

}
