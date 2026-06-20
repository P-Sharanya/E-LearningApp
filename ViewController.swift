//
//  ViewController.swift
//  App
//
//  Created by vasantha_m on 05/05/26.
//

import Foundation

class EnrollmentManager {

    static let shared = EnrollmentManager()

    private init() {}

    @Published var enrolledCourses: [Course] = []

    func enroll(course: Course) {

        if !enrolledCourses.contains(where: { $0.id == course.id }) {
            enrolledCourses.append(course)
        }
    }

    func withdraw(course: Course) {

        enrolledCourses.removeAll { $0.id == course.id }
    }

    func isEnrolled(course: Course) -> Bool {

        enrolledCourses.contains { $0.id == course.id }
    }
}
