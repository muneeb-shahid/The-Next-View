import SwiftUI

struct HorizontalListView: View {
    let headerText: String
    var titles: [Title]

    var body: some View {

        VStack(alignment: .leading, ) {
            Text(headerText).font(.title)
            Spacer()
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(titles, ) { imageURL in
                        AsyncImage(url: URL(string: imageURL.poster_path ?? ""))
                        { image in
                            image.resizable().scaledToFit().clipShape(
                                RoundedRectangle(cornerRadius: 10)

                            )
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 150, height: 250)

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
        titles: Title.previewTitles
    )
}
