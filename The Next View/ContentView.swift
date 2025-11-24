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
                Text("this is media screen")
            }
            Tab(
                Constants.searchString,
                systemImage: ImageConstants.searchImageName
            ) {
                Text("this is search screen")
            }
            Tab(
                Constants.downloadString,
                systemImage: ImageConstants.downloadImageName
            ) {
                Text("this is download screen")
            }
        }
    }
}

#Preview {
    ContentView()
}
