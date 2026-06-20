//
//  DashboardInteractor.swift
//  Learning
//
//  Created by vasantha_m on 25/03/26.
//

import Foundation

class DashboardInteractor {

    private let repository: JSONRepository
        private let user: User

        init(user: User, repository: JSONRepository = .shared) {
            self.user = user
            self.repository = repository
        }

        // MARK: - CORE DATA

        func fetchAllCourses() -> [Course] {
            repository.loadAppData().courses
        }

        func fetchUser() -> User {
            repository
                .loadAppData()
                .users
                .first(where: { $0.uid == user.uid }) ?? user
        }

        // MARK: - DASHBOARD SECTIONS

        func fetchDashboard() -> Dashboard {
            repository.loadAppData().dashboard
        }

        func fetchCarouselCourses() -> [Course] {
            let data = repository.loadAppData()

            return data.dashboard.carouselCourses.compactMap { id in
                data.courses.first { $0.id == id }
            }
        }

        func fetchRecentlyAdded() -> [Course] {
            let data = repository.loadAppData()

            return data.dashboard.recentlyAdded.compactMap { id in
                data.courses.first { $0.id == id }
            }
        }

        func fetchUpcomingCourses() -> [(course: Course?, date: String)] {
            let data = repository.loadAppData()

            return data.dashboard.upcomingCourses.map { item in
                let course = data.courses.first { $0.id == item.courseId }
                return (course, item.date)
            }
        }

    func getCurrentUser() -> User {
        user
    }
        // MARK: - COURSE DETAILS

        func fetchCourse(by id: String) -> Course? {
            repository
                .loadAppData()
                .courses
                .first { $0.id == id }
        }
}


