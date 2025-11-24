//
//  HomeView.swift
//  The Next View
//
//  Created by UTF LABS on 24/11/2025.
//

import SwiftUI

struct HomeView: View {
    
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string:ImageConstants.testTitleURL )){
                image in
                image
                    .resizable()
                    .scaledToFit()
            }placeholder: {
                ProgressView()
            }
            
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
            
            
        }
        
    }
}

#Preview {
    HomeView()
}
