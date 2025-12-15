import SwiftUI

struct TitleDetailView: View {

    var title: Title
    var viewModel = HomeViewModel()
    var titleName: String {
        return (title.name ?? title.title) ?? ""
    }
    var body: some View {
        GeometryReader { geometry in

            switch viewModel.videoIdStatus {
            case .notStarted:
                EmptyView()
            case .fetching:
                ProgressView().frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )

            case .success:
                ScrollView {
                    LazyVStack(alignment: .leading) {

                        YoutubePlayer(videoId: viewModel.videoId)
                            .aspectRatio(1.3, contentMode: .fit)

                        Text(titleName)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading, 10)

                        Text(title.overview ?? "")
                            .lineLimit(nil)
                            .padding(.leading, 10)

                    }

                }

            case .failed(let error):
                Text(error.localizedDescription)
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )

            }

        }
        .task {
            print("📺 TitleDetailView task started for: \(titleName)")
            await viewModel.getVideoId(for: titleName)
            print(
                "📺 TitleDetailView task completed. Status: \(viewModel.videoIdStatus)"
            )
        }
        .onAppear {
            print("📺 TitleDetailView appeared for: \(titleName)")

        }
    }

}

#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
