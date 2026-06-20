//
//  LoginPresenter.swift
//  Learning
//
//  Created by vasantha_m on 25/03/26.
//

import SwiftUI

class AuthPresenter: ObservableObject {

    @Published var message = ""
    @Published var isLoading = false

    private let interactor: AuthInteractor
    private let router: AuthRouter

    init(
        interactor: AuthInteractor,
        router: AuthRouter
    ) {
        self.interactor = interactor
        self.router = router
    }

    func login(
        email: String,
        password: String
    ) {

        isLoading = true

        interactor.login(
            email: email,
            password: password
        ) { [weak self] result in

            DispatchQueue.main.async {

                self?.isLoading = false

                switch result {

                case .success(let user):

                    self?.router.goToDashboard(
                        user: user
                    )

                case .failure(let error):

                    self?.message =
                        error.localizedDescription
                }
            }
        }
    }
    
    func register(
        email: String,
        password: String
    ) {

        isLoading = true

        interactor.register(
            email: email,
            password: password
        ) { [weak self] result in

            DispatchQueue.main.async {

                self?.isLoading = false

                switch result {

                case .success(let user):

                    self?.router.goToDashboard(
                        user: user
                    )

                case .failure(let error):

                    self?.message =
                        error.localizedDescription
                }
            }
        }
    }
}
