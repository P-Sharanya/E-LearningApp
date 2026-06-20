//
//  DashboardRouter.swift
//  Learning
//
//  Created by vasantha_m on 25/03/26.
//

import UIKit
import SwiftUI

class DashboardRouter {

    private let openCourse: (Course) -> Void
    private let openProfile: (User, [Course]) -> Void

    init(openCourse: @escaping (Course) -> Void,
         openProfile: @escaping (User, [Course]) -> Void) {
        self.openCourse = openCourse
        self.openProfile = openProfile
    }

    func goToCourse(_ course: Course) {
        self.openCourse(course)
    }

    func goToProfile(user: User, courses: [Course]) {
        self.openProfile(user, courses)
    }
}
