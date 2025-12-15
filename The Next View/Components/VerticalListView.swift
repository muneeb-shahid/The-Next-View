import SwiftUI

struct VerticalListView: View {
    var title: [Title]

    var body: some View {
        List(title) { title in
            NavigationLink {
                TitleDetailView(title: title)
            } label: {
                HStack {
                    AsyncImage(url: URL(string: title.poster_path ?? "")) {
                        image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 120, height: 180)

                    Text(title.name ?? title.title ?? "No Title")
                        .font(.headline)
                        .padding(.leading, 10)

                    Spacer()
                }
                .contentShape(Rectangle())
            }

        }
        .listStyle(.plain)
    }
}
