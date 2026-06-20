//
//  Course.swift
//  Learning
//
//  Created by vasantha_m on 25/04/26.
//

import Foundation

struct Course: Codable, Identifiable {
    let id: String
    let title: String
    let imageName: String
    let description: String
    let durations: String
    let rating: Double
    let whatYouWillLearn: [String]
    let lectures: [Lecture]
    let instructor: String
    let students: Int
}
