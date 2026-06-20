//
//  ProfileInteractor.swift
//  Learning
//
//  Created by vasantha_m on 25/04/26.
//

import Foundation

class ProfileInteractor {

    let user: User
    let courses: [Course]

    init(user: User, courses: [Course]) {
        self.user = user
        self.courses = courses
    }
}
