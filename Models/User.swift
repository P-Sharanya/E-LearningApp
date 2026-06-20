//
//  User.swift
//  Learning
//
//  Created by vasantha_m on 25/04/26.
//

import Foundation

struct User: Codable {

    let uid: String
    let email: String
}

struct UserLearningProfile: Codable {

    let uid: String
    var enrolledCourses: [String]
    var courseProgress: [String: Double]
    var lectureProgress: [String : [String : Double]]
    var achievements: [String]
    var certificates: [String]
    var streakDays: Int
}
