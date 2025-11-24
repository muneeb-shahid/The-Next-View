
import SwiftUI

struct HorizontalListView: View {
    let headerText : String
    let trendingImages = [ImageConstants.testTitleURL,ImageConstants.testTitleURL2, ImageConstants.testTitleURL3 ]
    
    
    var body: some View {
      
        
        VStack(alignment: .leading, ) {
            Text(headerText).font(.title)
            Spacer()
            ScrollView(.horizontal) {
                LazyHStack{
                    ForEach(trendingImages, id: \.self) { imageURL in
                        AsyncImage(url: URL(string: imageURL)){ image in
                            image.resizable().scaledToFit().clipShape(
                                
                                RoundedRectangle(cornerRadius: 10)
                            
                            )
                        }placeholder: {
                            ProgressView()
                        }
                        .frame(width: 150, height: 250)
                        
                    }
//                    .padding(.horizontal,0)
                    
                }
                
            }
            
            
        }
        .frame(height: 300,)
        .padding(.horizontal,5)

        
    }
}


#Preview {
    HorizontalListView(headerText:  Constants.trendingMovieString)
}
