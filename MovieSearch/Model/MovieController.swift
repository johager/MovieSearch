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
        else { fatalError("Could not find the file '\(fileName)'") }
        
        do {
            let plistData = try Data(contentsOf: filePath)
            
            guard let dict = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any]
            else { fatalError("Could not decode the '\(fileName).plist' file.") }
            
            guard let apiKey = dict["API Key"] as? String
            else { fatalError("The '\(fileName).plist' file does not contain an API Key.") }
            
            if apiKey.hasPrefix("_") {
                fatalError("Install a proper API Key in the '\(fileName).plist' file.")
            }
            
            print("apiKey: '\(apiKey)'")
            return apiKey
        } catch {
            fatalError("Error reding the plist file: \(error), \(error.localizedDescription)")
        }
    }()
    
    // MARK: - Methods
    
}
