//
//  RequestType.swift
//  MovieSearch
//
//  Created by James Hager on 4/8/22.
//

import Foundation

enum RequestType: String, CustomStringConvertible {
    case movieData
    case poster
    
    var description: String { rawValue }
    
    var url: URL? {
        switch self {
        case .movieData:
            return URL(string: "https://api.themoviedb.org/3/search/movie")
        case .poster:
            return URL(string: "https://image.tmdb.org/t/p/w500")
        }
    }
}
