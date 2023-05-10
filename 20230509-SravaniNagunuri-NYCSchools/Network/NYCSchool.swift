//
//  NYCSchool.swift
//  20230509-SravaniNagunuri-NYCSchools
//
//  Created by Sravani Nagunuri on 5/9/23.
//

import Foundation

/// This enum contains URLS for NYC Schools
/// Root URL - is the base url string
/// schoolDirectoryURL - Returns list of schools
/// getResultURL - return SAT scores for schools
///
enum NYCSchool {
    
    static let rootURLstring = "https://data.cityofnewyork.us"
    
    static let baseURL: URL = {
        guard let url = URL(string: rootURLstring) else {
          fatalError("Invalid baseURL")
        }
        return url
    }()
    
    static let schoolDirectoryURL: URL = {
        guard let url = URL(string: "\(rootURLstring)/resource/s3k6-pzi2.json") else {
          fatalError("Invalid url")
        }
        return url
    }()
    
    static func getResultURL(dbn: String?) -> URL {
        
        guard let dbn = dbn, let url = URL(string: "\(rootURLstring)/resource/f9bf-2cp4.json?dbn=\(dbn)") else {
          fatalError("invalid URL")
        }
        return url
    }
}
