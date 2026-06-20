//
//  LoginBuilder.swift
//  Learning
//
//  Created by vasantha_m on 25/03/26.
//

import UIKit
import SwiftUI

class AuthBuilder {
func create(
        openDashboard: @escaping (User) -> Void
    ) -> UIViewController {

        let router = AuthRouter(
            openDashboard: openDashboard
        )

        let interactor = AuthInteractor()

        let presenter = AuthPresenter(
            interactor: interactor,
            router: router
        )

        let view = AuthView(
            presenter: presenter
        )

        return UIHostingController(
            rootView: view
        )
    }
}
