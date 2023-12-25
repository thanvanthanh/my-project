//
//  LoginUserCases.swift
//  my-project-ios
//
//  Created by Thân Văn Thanh on 25/12/2023.
//

import Combine
import FirebaseAuth
import GoogleSignIn

protocol LoginUseCases: AnyObject {
    func signIn(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult?, Error>
    func signInGoogle(with credential: AuthCredential) -> AnyPublisher<AuthDataResult?, Error>
}

class LoginRequest: LoginUseCases {
    func signIn(withEmail email: String, password: String) -> AnyPublisher<AuthDataResult?, Error> {
        return Future<AuthDataResult?, Error> { promise in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(authResult))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signInGoogle(with credential: AuthCredential) -> AnyPublisher<AuthDataResult?, Error> {
        return Future<AuthDataResult?, Error> { promise in
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(authResult))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

