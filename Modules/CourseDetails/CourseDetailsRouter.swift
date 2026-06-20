//
//  CourseDetailsRouter.swift
//  Learning
//
//  Created by vasantha_m on 24/04/26.
//

import UIKit
import SwiftUI

class CourseDetailsRouter {

    private let onEnroll: () -> Void
    private let onLectureSelected: ((Lecture) -> Void)?


    init(onEnroll: @escaping () -> Void,
         onLectureSelected: ((Lecture) -> Void)? = nil) {
        self.onEnroll = onEnroll
        self.onLectureSelected = onLectureSelected
    }

    func enroll() {
        onEnroll()
    }
    func showLecture(_ lecture: Lecture) {
        onLectureSelected?(lecture)
    }
}
