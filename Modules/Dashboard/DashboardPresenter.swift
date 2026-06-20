//
//  DashboardPresenter.swift
//  Learning
//
//  Created by vasantha_m on 25/03/26.
//

import Foundation
import SwiftUI

class DashboardPresenter: ObservableObject {

    private let interactor: DashboardInteractor
    private let router: DashboardRouter

    @Published var courses: [Course] = []
    @Published var searchText: String = ""
    @Published var loadingStates: LoadingState = .idle
    
    @Published var carouselCourse: [Course] = []
    @Published var recentlyAddedCourses: [Course] = []
    @Published var upcomingCourses: [(course: Course?, date: String)] = []
    
    init(interactor: DashboardInteractor,
         router: DashboardRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    var filteredCourses: [Course] {
        if searchText.isEmpty {
            return courses
        } else {
            return courses.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func load() {
        courses = interactor.fetchAllCourses()
        carouselCourse = interactor.fetchCarouselCourses()
        recentlyAddedCourses = interactor.fetchRecentlyAdded()
        upcomingCourses = interactor.fetchUpcomingCourses()
    }

    func didSelect(course: Course) {
        router.goToCourse(course)
    }

    func profileTapped() {
        router.goToProfile(user: interactor.getCurrentUser(),
                           courses: EnrollmentManager.shared.enrolledCourses)
    }
    
}

 
