//
//  UpcomingView.swift
//  The Next View
//
//  Created by UTF LABS on 08/12/2025.
//

import SwiftUI

struct UpcomingView: View {

    @State private var viewModel = HomeViewModel()       


    var body: some View {
        NavigationStack() {
            GeometryReader { geo in
                switch viewModel.upcomingStatus {
                case .notStarted:
                    EmptyView()
                        .onAppear { print("📍 UpcomingView status: notStarted") }

                case .fetching:
                    ProgressView()
                        .onAppear { print("📍 UpcomingView status: fetching") }
//                        .frame(
//                            width: geo.size.width,
//                            height: geo.size.height,
//                        )

                case .success:
                    VerticalListView(
                        title: viewModel.upcomingMovies,
                       
                    )
                    .onAppear { 
                        print("📍 UpcomingView status: success")
                        print("📍 Upcoming movies count: \(viewModel.upcomingMovies.count)")
                    }

                case .failed(let error):
                    Text(error.localizedDescription)
                        .frame(
                            width: geo.size.width,
                            height: geo.size.height
                        )
                        .onAppear { 
                            print("📍 UpcomingView status: failed")
                            print("📍 Error: \(error.localizedDescription)")
                        }
                }

            }

        }.task {
            await viewModel.getUpcomingmovies()
        }

    }
}

#Preview {
    UpcomingView()
}
