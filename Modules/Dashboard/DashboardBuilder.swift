//
//  DashboardBuilder.swift
//  Learning
//
//  Created by vasantha_m on 25/04/26.
//

import UIKit
import SwiftUI

class DashboardBuilder {

    func createVC(user: User,
                  openCourse: @escaping (Course) -> Void,
                  openProfile: @escaping (User, [Course]) -> Void) -> UIViewController {

        let interactor = DashboardInteractor(user: user)

        let router = DashboardRouter(
            openCourse: openCourse,
            openProfile: openProfile
        )

        let presenter = DashboardPresenter(
            interactor: interactor,
            router: router
        )

        let view = DashboardView(presenter: presenter)

        return UIHostingController(rootView: view)
    }
}
