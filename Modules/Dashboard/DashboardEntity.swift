//
//  DashboardEntity.swift
//  Learning
//
//  Created by vasantha_m on 25/03/26.
//
//

import Foundation

enum LoadingState {
    case idle
    case loading
    case loaded
    case error
}
struct AppData: Codable {
    let app: AppInfo
    let users: [User]
    let courses: [Course]
    let dashboard: Dashboard
}

struct AppInfo: Codable {
    let name: String
}
struct Dashboard: Codable {
    let carouselCourses: [String]
    let recentlyAdded: [String]
    let upcomingCourses: [UpcomingCourse]
}

struct UpcomingCourse: Codable, Identifiable {
    let courseId: String
    let date: String

    var id: String { courseId + date }
}
