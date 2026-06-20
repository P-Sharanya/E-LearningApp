//
//  LectureBuilder.swift
//  App
//
//  Created by vasantha_m on 10/06/26.
//

import SwiftUI

class LectureBuilder {

    func createVC(
        course: Course,
        lecture: Lecture
    ) -> UIViewController {

        let interactor = LectureInteractor()

        let router = LectureRouter()

        let presenter = LecturePresenter(
            course: course,
            lecture: lecture,
            router: router,
            interactor: interactor
        )

        let view = LectureDetailsView(
            presenter: presenter
        )

        return UIHostingController(
            rootView: view
        )
    }
}
