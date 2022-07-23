//
//  MovieCellViewModel.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import Foundation

struct MovieListCellViewModel {
    var id: Int
    var name: String
    var desc: String
    var poster: String
    var date: String
    
    init(movie: Movie) {
        self.id = movie.id
        self.name = movie.title
        self.desc = movie.overview
        self.poster = movie.getFullPosterPath()
        self.date = movie.getFormattedReleaseDate()
    }
}
