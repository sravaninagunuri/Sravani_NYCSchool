//
//  School.swift
//  20230509-SravaniNagunuri-NYCSchools
//
//  Created by Sravani Nagunuri on 5/9/23.
//

import Foundation

struct School: Codable {
    
    var dbn: String?
    var schoolName: String?
    var overviewParagraph: String?
    var latitude: String?
    var longitude: String?
    var location: String?
    var phone: String?
    var email: String?
    var website: String?
    var city: String
    var zip: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn, latitude, longitude, location, website, city
        case schoolName = "school_name"
        case overviewParagraph = "overview_paragraph"
        case phone = "phone_number"
        case email = "school_email"
        case zip = "zip"
    }
    
}

