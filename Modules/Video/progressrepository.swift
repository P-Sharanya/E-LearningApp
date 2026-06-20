//
//  VideoInteractor.swift
//  App
//
//  Created by vasantha_m on 10/06/26.
//

import Foundation

class ProgressRepository {

    static let shared = ProgressRepository()

    private init() {}

    private var lectureProgress: [String: Double] = [:]

    func saveProgress(
        lectureId: String,
        progress: Double
    ) {
        lectureProgress[lectureId] = progress
    }

    func getProgress(
        lectureId: String
    ) -> Double? {
        lectureProgress[lectureId]
    }

    func lectureCompleted(
        courseId: String,
        lectureId: String
    ) {

        lectureProgress[lectureId] = 1.0

        print(
            "Completed \(lectureId) in \(courseId)"
        )
    }
}
