//
//  TitleDetailView.swift
//  The Next View
//
//  Created by UTF LABS on 04/12/2025.
//

import SwiftUI

struct TitleDetailView: View {

    var title: Title
    var body: some View {
        GeometryReader { geometry in
            ScrollView {

                LazyVStack(alignment: .leading, spacing: 20) {
                    AsyncImage(url: URL(string: title.poster_path ?? "")) {
                        image in
                        image.resizable().scaledToFit()

                    } placeholder: {
                        ProgressView()
                    }

                    Text((title.name ?? title.title) ?? "")
                        .font(.title2)
                        .fontWeight(.bold)

                        .padding(.leading, 10)

                    Text(title.overview ?? "")
                        .lineLimit(nil)
                        .padding(.leading, 10)
                }

            }
        }
    }
}

#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
