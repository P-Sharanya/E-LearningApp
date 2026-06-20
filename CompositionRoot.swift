//
//  CompositionRoot.swift
//  App
//
//  Created by vasantha_m on 05/05/26.
//

import UIKit
import SwiftUI
import FirebaseAuth

class CompositionRoot {

    private let navigationController =
        UINavigationController()

    func getNavVC() -> UIViewController {
        
        if AuthManager.shared.isLoggedIn {
            
            let firebaseUser = Auth.auth().currentUser

            let user = User(
                uid: firebaseUser?.uid ?? "",
                email: firebaseUser?.email ?? ""
            )

            showDashboard(user: user)

        } else {

            showLogin()
        }

        return navigationController
    }

    func showLogin() {

        let vc = AuthBuilder().create {
            [weak self] user in

            self?.showDashboard(user: user)
        }

        navigationController.setViewControllers(
            [vc],
            animated: false
        )
    }

    func showDashboard(user: User) {

        let vc = DashboardBuilder().createVC(
            user: user,openCourse: { [weak self] course in
                self?.showCourse(course)
            },
            openProfile: { [weak self] user, courses in
                self?.showProfile(
                    user: user,
                    courses: courses
                )
            }
        )
        
        self.navigationController.pushViewController(
            vc,
            animated: true
        )
    }

    func showCourse(_ course: Course) {
        let vc = CourseDetailsBuilder().createVC(
            course: course,
            onEnroll: {
                print("Enroll callback")
            },onLectureSelected: { [weak self] lecture in
                self?.showLecture(course:course,lecture:lecture)
            }
        )
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showProfile(user: User, courses: [Course]) {
        let vc = ProfileBuilder().createVC(user: user, courses: courses, logout: { [weak self] in
            
            try? AuthManager.shared.logout()
            
                 self?.showLogin()
        })
        self.navigationController.pushViewController(vc, animated: true)
    }
    func showLecture(
        course: Course,
        lecture: Lecture
    ) {

        let vc = LectureBuilder().createVC(
            course: course,
            lecture: lecture
        )

        navigationController.pushViewController(
            vc,
            animated: true
        )
    }
    

}
                
                
