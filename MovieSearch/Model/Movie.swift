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
    let originalTitle: String?
    let releaseDateString: String?
    let rating: Float?
    let popularity: Float?
    let overview: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case originalTitle = "original_title"
        case releaseDateString = "release_date"
        case rating = "vote_average"
        case popularity
        case overview
        case posterPath = "poster_path"
    }
}
