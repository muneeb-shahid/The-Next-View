import SwiftUI

struct HorizontalListView: View {
    let headerText: String
    var titles: [Title]
    let onTap: (Title) -> Void

    var body: some View {

        VStack(alignment: .leading, ) {
            Text(headerText).font(.title)
            Spacer()
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(titles) { title in
                        AsyncImage(url: URL(string: title.poster_path ?? "")) {
                            image in
                            image.resizable().scaledToFit().clipShape(
                                RoundedRectangle(cornerRadius: 10)

                            )
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 150, height: 250)
                        .onTapGesture {
                            onTap(title)
                        }

                    }

                }

            }

        }
        .frame(height: 300, )
        .padding(.horizontal, 5)

    }
}

#Preview {
    HorizontalListView(
        headerText: Constants.trendingMovieString,
        titles: Title.previewTitles,
        onTap: {
            title in
        }
    )
}
