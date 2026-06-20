//
//  ProfileBulder.swift
//  Learning
//
//  Created by vasantha_m on 25/04/26.
//

import UIKit
import SwiftUI

class ProfileBuilder {

    func createVC(user: User,
                  courses: [Course],
                  logout: @escaping () -> Void) -> UIViewController {

        let interactor = ProfileInteractor(user: user,
                                           courses: courses)

        let router = ProfileRouter(logout: logout)

        let presenter = ProfilePresenter(
            interactor: interactor,
            router: router
        )

        let view = ProfileView(presenter: presenter)

        return UIHostingController(rootView: view)
    }
}
