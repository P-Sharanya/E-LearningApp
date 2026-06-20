//
//  CourseDetailsInteractor.swift
//  Learning
//
//  Created by vasantha_m on 24/04/26.
//

import Foundation

class CourseDetailsInteractor {

    func getLectures(course: Course) -> [Lecture] {
        return course.lectures
    }
}
