//
//  ContentView.swift
//  The Next View
//
//  Created by UTF LABS on 17/11/2025.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            Tab(Constants.homeString, systemImage: ImageConstants.homeImageName)
            {
                HomeView()

            }
            Tab(
                Constants.upcomingString,
                systemImage: ImageConstants.upcomingImageName
            ) {
                UpcomingView()
            }
            Tab(
                Constants.searchString,
                systemImage: ImageConstants.searchImageName
            ) {
                SearchView()
            }

        }

    }
}

#Preview {
    ContentView()
}
