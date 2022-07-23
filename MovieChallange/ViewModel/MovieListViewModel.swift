//
//  MovieListViewModel.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import Foundation

class MovieListViewModel: NSObject {
    
    var reloadTableView: (() -> Void)?
    var setupTableView: (() -> Void)?
    var connectionError: (() -> Void)?
    
    var movieSliderSource = [Movie]()
    var movieListSource = [Movie]()
    
    var movieListSliderCellViewModel: MovieListSliderCellViewModel?
    
    var movieCellViewModels = [MovieListCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var isLoading = false
    
    var page = 1
    
    func fetchData(){
        isLoading = true
        if page == 1 {
            API.fetchMovieList(url: Urls.NOW_PLAYING,
                               success: { sliderMovieListResponse in
                self.movieSliderSource = sliderMovieListResponse.results
                self.movieListSliderCellViewModel = MovieListSliderCellViewModel(movies: self.movieSliderSource)
                self.fetchListMovies()
            }, failure: { sliderMoviesError in
                print(sliderMoviesError)
                self.isLoading = false
                self.connectionError?()
            })
        } else {
            fetchListMovies()
        }
        
    }

    func fetchListMovies(){
        API.fetchMovieList(url: Urls.UPCOMING,
                           page: page,
                           success: { movieListResponse in
            self.movieListSource += movieListResponse.results
            var tempCellVMList = [MovieListCellViewModel]()
            for movie in self.movieListSource {
                tempCellVMList.append(MovieListCellViewModel(movie: movie))
            }
            self.movieCellViewModels = tempCellVMList
            self.setupTableView?()
            self.isLoading = false
        }, failure: { movieListError in
            print(movieListError)
            self.connectionError?()
            self.isLoading = false
        })
    }
}
