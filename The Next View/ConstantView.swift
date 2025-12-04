struct Constants {

    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let downloadString = "Download"
    static let playString = "Play"
    static let movieString = "movie"
    static let tvString = "tv"
    
    static let topUnderScoreRatedString = "top_rated"
    static let trendingString = "trending"
    static let trendingMovieString = "Trending Movies"
    static let trendingTVString = "Trending TV"
    static let topRatedMovieString = "Top Rated Movies"
    static let topRatedTVString = "Top Rated TV"
    static let movieSearchString = "Movie Search"
    static let tvSearchString = "TV Search"
    static let moviePlaceHolderString = "Search for a Movie"
    static let tvPlaceHolderString = "Search for a TV Show"
    
    
    
    static func addPosterPath(to titles: inout[Title]){
        for i in titles.indices{
            print("poster path indexing ......\(i)")
            if let path = titles[i].poster_path{
                titles[i].poster_path = ImageConstants.posterURLStart + path
                
                print("poster path ......\(path)")
            }
        }
        
        
    }
}
