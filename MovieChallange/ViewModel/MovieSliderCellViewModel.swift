//
//  MovieSliderCellViewModel.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import Foundation

struct MovieSliderCellViewModel {
    var id: Int
    var name: String
    var desc: String
    var poster: String
    
    init(movie: Movie) {
        self.id = movie.id
        self.name = movie.title
        self.desc = movie.overview
        self.poster = movie.getFullPosterPath()
    }
}

