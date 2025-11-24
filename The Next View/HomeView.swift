//
//  HomeView.swift
//  The Next View
//
//  Created by UTF LABS on 24/11/2025.
//

import SwiftUI

struct HomeView: View {

    var body: some View {
        GeometryReader { geo in
            ScrollView() {
                LazyVStack{
                    AsyncImage(url: URL(string:ImageConstants.testTitleURL )){
                        image in
                        image
                            .resizable()
                            .scaledToFit()
                            .overlay{
                                LinearGradient(
                                    stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .gradient, location: 1)],
                                    startPoint:.top,
                                               endPoint: .bottom)
                                
                            }
                    }
                  
                    
                    placeholder: {
                        ProgressView()
                    }
                    
                    .frame(width:geo.size.width, height: geo.size.height*0.85,)
                    HStack {
                        Button{
                            
                        }label: {
                            Text(Constants.playString)
                                .buttonUI()
                            
                        }
                        .frame(width: 150)
                        Button{
                            
                        }label: {
                            Text(Constants.downloadString)
                                .buttonUI()
                        }
                        
                    }
                    HorizontalListView(headerText: Constants.trendingMovieString)
                    HorizontalListView(headerText: Constants.trendingTVString)
                    HorizontalListView(headerText: Constants.topRatedTVString)
                    HorizontalListView(headerText: Constants.topRatedMovieString)
                    
                    
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
