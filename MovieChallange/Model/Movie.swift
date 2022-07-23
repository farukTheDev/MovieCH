//
//  Movie.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let adult: Bool
    let original_title: String
    let overview: String
    var poster_path: String?
    let title: String
    let vote_average: Float
    let release_date: String
    let imdb_id: String?
    
    func getFullPosterPath() -> String {
        if let pp = poster_path {
            return Urls.POSTER_BASE + pp
        }
        return "https://toppng.com/uploads/preview/clapperboard-camera-roll-film-11562898896wrhdgjp1ah.png"
    }
    
    func getFormattedReleaseDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yyyy"

        if let date = dateFormatterGet.date(from: self.release_date) {
            return dateFormatterPrint.string(from: date)
        } else {
           return "error while formatting date"
        }
    }
}
