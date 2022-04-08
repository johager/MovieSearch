//
//  Movie.swift
//  MovieSearch
//
//  Created by James Hager on 4/8/22.
//

import Foundation

struct MovieData: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    let title: String
    let originalTitle: String
    let releaseDataString: String
    let rating: Float
    let popularity: Float
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case originalTitle = "original_title"
        case releaseDataString = "release_date"
        case rating = "vote_average"
        case popularity
        case posterPath = "poster_path"
    }
}
