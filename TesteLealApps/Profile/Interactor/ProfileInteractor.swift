//
//  ProfileInteractor.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 07/01/22.
//

import Foundation
import Combine

class ProfileInteractor {
    
    private let remote: ProfileRemoteDataSource = .shared
    
    private let firebase: ProfileRemoteDataSource = .shared
    
    private let local: ProfileRemoteDataSource = .shared
    
}

extension ProfileInteractor {
    
    func fetchUser() -> Future<ProfileResponse, AppError> {
        return remote.fetchUser()
    }
    
    func updateUser(userId: Int, profileRequest: ProfileRequest) -> Future<ProfileResponse, AppError> {
        return remote.updateUser(userId: userId, request: profileRequest)
    }
    
    func insertAuth() -> Future<ProfileResponse, AppError> {
        return remote.fetchUser()
    }
    //        func insertAuth() -> Future<ProfileResponse, AppError> {
    //            return remote.fetchUser()
    //        }
}

