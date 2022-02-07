//
//  SignUpInteractor.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//

import Foundation
import Combine

class SignUpInteractor {
    
    private let remoteSignUp: RegistrationServiceImpl = .shared
    private let remoteSignIn: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
}
     
extension SignUpInteractor {

    func postUser(signUpRequest request: RegistrationModel) -> AnyPublisher<Void, Error> {
        return remoteSignUp.register(with: request)
    }
    
    func login(signInRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remoteSignIn.login(request: request)
    }
    
    func insertAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
    
}
