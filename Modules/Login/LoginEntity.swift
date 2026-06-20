//
//  LoginEntity.swift
//  Learning
//
//  Created by vasantha_m on 25/03/26.
//
//

import FirebaseAuth
import Foundation

class AuthManager {

    static let shared = AuthManager()

    private init() {}

    func register(
        email: String,
        password: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {

        Auth.auth().createUser(
            withEmail: email,
            password: password
        ) { result, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            completion(.success(result?.user.uid ?? ""))
        }
    }

    func login(
        email: String,
        password: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {

        Auth.auth().signIn(
            withEmail: email,
            password: password
        ) { result, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            completion(.success(result?.user.uid ?? ""))
        }
    }

    func logout() throws {
        try Auth.auth().signOut()
    }

    var isLoggedIn: Bool {
        Auth.auth().currentUser != nil
    }
}
