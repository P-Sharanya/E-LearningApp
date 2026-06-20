//
//  ProfileRouter.swift
//  Learning
//
//  Created by vasantha_m on 25/04/26.
//

import UIKit
import SwiftUI


class ProfileRouter {

    private let logout: () -> Void

    init(logout: @escaping () -> Void) {
        self.logout = logout
    }

    func goToLogin() {
        logout()
    }
}
