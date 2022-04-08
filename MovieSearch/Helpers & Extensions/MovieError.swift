//
//  MovieError.swift
//  MovieSearch
//
//  Created by James Hager on 4/8/22.
//

import Foundation

enum MovieError: LocalizedError {
    
    case invalidURL(RequestType)
    case urlSessionError(RequestType, Error)
    case httpResponseStatusCode(RequestType, Int)  // Int is for statusCode
    case noData(RequestType)
    case unableToDecodeMovieData(Error)
    case unableToDecodePosterImage
    
    var errorDescription: String? {
        switch self {
        case .invalidURL(let requestType):
            return "The \(requestType) request had an invalid URL."
        case .urlSessionError(let requestType, let error):
            return "There was an error downloading \(requestType) data: \(error.localizedDescription)"
        case .httpResponseStatusCode(let requestType, let statusCode):
            return "The server responded to the \(requestType) request with status \(statusCode)."
        case .noData(let requestType):
            return "There was no data returned for the \(requestType) request."
        case .unableToDecodeMovieData(let error):
            return "Unable to decode movie data: \(error.localizedDescription)"
        case .unableToDecodePosterImage:
            return "Unable to decode the poster image data."
        }
    }
}
