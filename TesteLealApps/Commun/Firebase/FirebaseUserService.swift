//
//  FirebaseUserService.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 10/01/22.
//

import Combine
import FirebaseAuth

protocol UserServiceProtocol {
    var currentUser:User? {
        get
    }
    func currentUserPublisher() -> AnyPublisher<User?, Never>
    func signInAnonymusly() -> AnyPublisher<User,FirebaseAppError>
    func observeAuthChanges() -> AnyPublisher<User?,Never>
    func linkAccount(email:String,password:String) -> AnyPublisher<Void,FirebaseAppError>
    func logout() -> AnyPublisher<Void,FirebaseAppError>
    func login(email:String,password:String) -> AnyPublisher<Void,FirebaseAppError>
}

final class UserService:UserServiceProtocol{
    let currentUser = Auth.auth().currentUser
    func currentUserPublisher() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func signInAnonymusly() -> AnyPublisher<User, FirebaseAppError> {
        return Future<User,FirebaseAppError>{ promise in
            Auth.auth().signInAnonymously { result,error in
                if let error = error {
                    return promise(.failure(.auth(description: error.localizedDescription)))
                }else if let user = result?.user {
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func observeAuthChanges() -> AnyPublisher<User?, Never> {
        Publishers.AuthPublisher().eraseToAnyPublisher()
    }
    
    func linkAccount(email: String, password: String) -> AnyPublisher<Void, FirebaseAppError> {
        let emailCredential = EmailAuthProvider.credential(withEmail: email, password: password)
        return Future<Void,FirebaseAppError> { promise in
            Auth.auth().currentUser?.link(with: emailCredential){ result, error in
                if let error = error {
                    return promise(.failure(.default(description: error.localizedDescription)))
                }else if let user = result?.user {
                    Auth.auth().updateCurrentUser(user){error in
                        if let error = error {
                            return promise(.failure(.default(description: error.localizedDescription)))
                        }else{
                            return promise(.success(()))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func logout() -> AnyPublisher<Void, FirebaseAppError> {
        return Future<Void,FirebaseAppError> { promise in
            do{
                try Auth.auth().signOut()
                promise(.success(()))
            } catch {
                promise(.failure(.default(description: error.localizedDescription)))
            }
        }.eraseToAnyPublisher()
    }
    
    func login(email: String, password: String) -> AnyPublisher<Void, FirebaseAppError> {
        return Future<Void,FirebaseAppError>{ promise in
            Auth.auth().signIn(withEmail: email, password: password){ result,error in
                if let error = error {
                    promise(.failure(.default(description: error.localizedDescription)))
                }else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
