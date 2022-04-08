//
//  MovieController.swift
//  MovieSearch
//
//  Created by James Hager on 4/8/22.
//

import Foundation

class MovieController {
    
    // MARK: - Properties
    
    lazy var apiKey: String = {
        let fileName = "TMDB-Info"
        
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: "plist")
        else { fatalError("Could not find the file \(fileName).plist") }
        
        do {
            let plistData = try Data(contentsOf: filePath)
            
            guard let dict = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any]
            else { fatalError("Could not decode the \(fileName).plist file.") }
            
            guard let apiKey = dict["API Key"] as? String
            else { fatalError("The \(fileName).plist file does not contain an API Key.") }
            
            if apiKey.hasPrefix("_") {
                fatalError("Install a proper API Key in the \(fileName).plist file.")
            }
            
            print("apiKey: '\(apiKey)'")
            return apiKey
        } catch {
            fatalError("Error reding the \(fileName).plist file: \(error), \(error.localizedDescription)")
        }
    }()
    
    // MARK: - Methods
    
    func getMovies(withTitle title: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        let requestType = RequestType.movieData
        
        guard let url = requestType.url else { return completion(.failure(.invalidURL(requestType)))}
        
        let queryItems = [
            "query": title,
            "api_key": apiKey
        ]
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL(requestType)))}
        
        print("\(requestType) finalURL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.urlSessionError(requestType, error)))
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    return completion(.failure(.httpResponseStatusCode(requestType, response.statusCode)))
                }
            }
            
            guard let data = data else { return completion(.failure(.noData(requestType)))}
            
            do {
                let movieData = try JSONDecoder().decode(MovieData.self, from: data)
                return completion(.success(movieData.movies))
            } catch {
                completion(.failure(.unableToDecodeMovieData(error)))
            }
        }.resume()
    }
}
