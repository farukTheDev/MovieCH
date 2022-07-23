//
//  MovieListSliderCellViewModel.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import Foundation

struct MovieListSliderCellViewModel {
    var movies: [Movie]
    
    func generateMovieSliderCellViewModels() -> [MovieSliderCellViewModel] {
        var vmList = [MovieSliderCellViewModel]()
        for movie in movies {
            vmList.append(MovieSliderCellViewModel(movie: movie))
        }
        return vmList
    }
}
