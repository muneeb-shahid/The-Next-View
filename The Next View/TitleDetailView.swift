//
//  TitleDetailView.swift
//  The Next View
//
//  Created by UTF LABS on 04/12/2025.
//

import SwiftUI

struct TitleDetailView: View {

    var title: Title
    var viewModel = ViewModel()
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
//                                                AsyncImage(url: URL(string: title.poster_path ?? "")) {
//                                                    image in
//                                                    image.resizable().scaledToFit()
//                        
//                                                } placeholder: {
//                                                    ProgressView()
//                                                        .frame(
//                                                            width: geometry.size.width,
//                                                            height: geometry.size.height
//                                                        )
//                                                }

                        YoutubePlayer(videoId: viewModel.videoId)
                            .aspectRatio(1.3, contentMode: .fit)

//                                                                    YoutubePlayer(videoId: "I9Y5qYp8ro8")
//                                                                        .aspectRatio(1.3, contentMode: .fit)

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
                    //                    errorMessage()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )

            }

        }
        .task {
            print("task of title detail view")
            await viewModel.getVideoId(for: titleName)
        }
        .onAppear {
            print("on appear of title detail view")
//           viewModel.getVideoId(for: titleName)
        }
    }

}

#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
