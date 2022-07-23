//
//  MovieDetailViewModel.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import Foundation

class MovieDetailViewModel: NSObject {
    
    var navigate: (() -> Void)?
    var connectionError: (() -> Void)?
    var title: String = ""
    var overView: String = ""
    var poster: String = ""
    var date: String = ""
    var rate: String = ""
    var imdb_id: String = ""
    
    func fetchMovie(id: Int){
        API.fetchMovie(url: Urls.DETAIL(id: id),
                       success: { movie in
            self.title = movie.title
            self.overView = movie.overview + movie.overview + movie.overview + movie.overview + movie.overview
            /* Since overview text are too short to proof scrollview works, I have added same text to itself multiple times.*/
            self.poster = movie.getFullPosterPath()
            self.date = movie.getFormattedReleaseDate()
            self.rate = String(format: "%.1f", movie.vote_average)
            self.imdb_id = movie.imdb_id ?? ""
            self.navigate?()
        }, failure: { movieListError in
            self.connectionError?()
        })
    }
}
