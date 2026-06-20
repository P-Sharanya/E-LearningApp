//
//  LoginInteractor.swift
//  Learning
//
//  Created by vasantha_m on 25/03/26.
//

import Foundation

class AuthInteractor {

    func login(
        email: String,
        password: String,
        completion: @escaping(Result<User, Error>) -> Void
    ) {

        AuthManager.shared.login(
            email: email,
            password: password
        ) { result in

            switch result {

            case .success(let uid):
                completion(
                    .success(
                        User(
                            uid: uid,
                            email: email
                        )
                    )
                )

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func register(
        email: String,
        password: String,
        completion: @escaping(Result<User, Error>) -> Void
    ) {

        AuthManager.shared.register(
            email: email,
            password: password
        ) { result in

            switch result {

            case .success(let uid):
                completion(
                    .success(
                        User(
                            uid: uid,
                            email: email
                        )
                    )
                )

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
