//
//  SATScore.swift
//  20230509-SravaniNagunuri-NYCSchools
//
//  Created by Sravani Nagunuri on 5/9/23.
//

import Foundation

struct SATScore: Codable {
    var dbn: String?
    var schoolName: String?
    var reading: String?
    var math: String?
    var writing: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case reading = "sat_critical_reading_avg_score"
        case math = "sat_math_avg_score"
        case writing = "sat_writing_avg_score"
    }
}

