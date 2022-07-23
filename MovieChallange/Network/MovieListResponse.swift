//
//  MovieListResponse.swift
//  MovieChallange
//
//  Created by Ömer Faruk KISIK on 23.07.2022.
//

import Foundation

struct MovieListResponse: Codable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
}
