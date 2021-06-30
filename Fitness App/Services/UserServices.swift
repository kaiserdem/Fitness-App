//
//  UserServices.swift
//  Fitness App
//
//  Created by Kaiserdem on 30.06.2021.
//

import Combine
import FirebaseAuth

protocol UserServicesProtocol {
    func currentUser() -> AnyPublisher<User?,Never>
    func signInAnonymously() -> AnyPublisher<User,Error>
}

final class UserService: UserServicesProtocol {
    func currentUser() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func signInAnonymously() -> AnyPublisher<User, Error> {
        return Future<User, Error> { promise in
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    return promise(.failure(error))
                } else if let user = result?.user {
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    
}