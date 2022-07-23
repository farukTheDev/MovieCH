//
//  API.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import Foundation
import Alamofire
import ProgressHUD

class Urls{
    static let BASE = "https://api.themoviedb.org/3/movie/"
    static let POSTER_BASE = "https://image.tmdb.org/t/p/original"
    static let NOW_PLAYING = BASE + "now_playing?api_key=\(Constants.API_KEY)&language=en-US&"
    static let UPCOMING = BASE + "upcoming?api_key=\(Constants.API_KEY)&language=en-US&"
    
    
    static func IMDB_LINK(imdb_id: String) -> String {
        return "https://www.imdb.com/title/\(imdb_id)/"
    }
    
    static func DETAIL(id: Int) -> String {
        return BASE + "\(id)?api_key=\(Constants.API_KEY)&language=en-US&"
    }
}


class API {
    class func fetchMovieList(url: String,
                              page: Int? = nil,
                              success: @escaping (_ movieListResponse: MovieListResponse) -> Void,
                              failure: @escaping (_ error: AFError) -> Void) {
        ProgressHUD.show()
        var urlString = url
        
        if page != nil {
            urlString += "&page=\(page!)"
        }
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseDecodable(of: MovieListResponse.self) { response in
            ProgressHUD.dismiss()
            if let responseResult = response.value {
                success(responseResult)
            } else {
                failure(response.error!)
            }
        }
    }
    
    class func fetchMovie(url:String,
                          success: @escaping (_ movieListResponse: Movie) -> Void,
                          failure: @escaping (_ error: AFError) -> Void) {
        ProgressHUD.show()
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseDecodable(of: Movie.self) { response in
            ProgressHUD.dismiss()
            if let responseResult = response.value {
                success(responseResult)
            } else {
                failure(response.error!)
            }
        }
    }
}
