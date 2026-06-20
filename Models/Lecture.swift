//
//  Lecture.swift
//  Learning
//
//  Created by vasantha_m on 25/04/26.
//

import Foundation

struct Lecture: Codable, Identifiable {
    let id: String
    let title: String
    let duration: String
    let videoUrl: String
    var progress: Double
    var isLocked: Bool
}
