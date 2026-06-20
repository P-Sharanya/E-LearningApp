//
//  CourseDetailsPresenter.swift
//  Learning
//
//  Created by vasantha_m on 24/04/26.
//

import Foundation

class CourseDetailsPresenter: ObservableObject {

    private let interactor: CourseDetailsInteractor
    private let router: CourseDetailsRouter

   // @Published var loadingStates: LoadingStates = .idle
    
    @Published var course: Course
    @Published var lectures: [Lecture] = []
    @Published var isEnrolled: Bool = false

    init(course: Course,
         interactor: CourseDetailsInteractor,
         router: CourseDetailsRouter) {

        self.course = course
        self.interactor = interactor
        self.router = router

        self.lectures = interactor.getLectures(course: course)
        self.isEnrolled = EnrollmentManager.shared.isEnrolled(course: course)
    }

    func enrollTapped() {
        EnrollmentManager.shared.enroll(course: course)

        isEnrolled = true
        router.enroll()
    }
    func withdrawTapped() {
        EnrollmentManager.shared.withdraw(course: course)

        isEnrolled = false
        //router.enroll()
    }
    var courseProgress: Double {

        guard !lectures.isEmpty else { return 0 }

        let total = lectures.reduce(0) {
            $0 + $1.progress
        }

        return total / Double(lectures.count)
    }
    func continueLearningTapped() {
        guard let nextLecture = lectures.first(where: {
            $0.progress < 1
        }) else { return }

        router.showLecture(nextLecture)
    }

    func lectureTapped(_ lecture: Lecture) {
        router.showLecture(lecture)
    }
}
