//
//  SchoolDetailsViewModel.swift
//  20230509-SravaniNagunuri-NYCSchools
//
//  Created by Sravani Nagunuri on 5/9/23.
//

import Foundation

class SchoolDetailsViewModel {
    
    /// Fetch Schools details from backend api
    /// - Parameters:
    ///   - networkManager: network manager instance
    ///   - school: School model object
    ///   - completionHandler: completion handler with optional scores and  optional error
    func getDetails(forSelectedSchool
        school: School,
        completionHandler: @escaping (([SATScore]?, Error?) -> Void)
    ) {
        WebService().fetchData(url: NYCSchool.getResultURL(dbn: school.dbn)) { (response: [SATScore]?, error) in
            
            if (response?.first(where: { $0.dbn == school.dbn })) != nil {
                completionHandler(response, error)
            } else {
                completionHandler(nil, error)
            }
        }
    }
}
