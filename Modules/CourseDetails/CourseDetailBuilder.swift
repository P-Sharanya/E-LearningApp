//
//  CourseDetailBuilder.swift
//  Learning
//
//  Created by vasantha_m on 25/04/26.
//

import UIKit
import SwiftUI

class CourseDetailsBuilder {

    func createVC(course: Course,
                  onEnroll: @escaping () -> Void,
                  onLectureSelected: @escaping (Lecture) -> Void) -> UIViewController {

        let interactor = CourseDetailsInteractor()

        let router = CourseDetailsRouter(onEnroll: onEnroll,onLectureSelected: onLectureSelected)

        let presenter = CourseDetailsPresenter(
            course: course,
            interactor: interactor,
            router: router
        )

        let view = CourseDetailsView(presenter: presenter)

        return UIHostingController(rootView: view)
    }
}
