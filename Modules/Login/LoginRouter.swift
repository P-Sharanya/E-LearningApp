//
//  LoginRouter.swift
//  Learning
//
//  Created by vasantha_m on 25/03/26.
//

import UIKit
import SwiftUI

class AuthRouter {

    private let openDashboard:
        (User) -> Void

    init(
        openDashboard: @escaping (User) -> Void
    ) {
        self.openDashboard = openDashboard
    }

    func goToDashboard(user: User) {
        openDashboard(user)
    }
}
