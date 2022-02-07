//
//  ProfileRemoteDataSource.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 07/01/22.
//

import Foundation
import Combine
import FirebaseAuth

class ProfileRemoteDataSource {
    
    static var shared: ProfileRemoteDataSource = ProfileRemoteDataSource()
    
    private init() {
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
    
    func fetchUser() -> Future<ProfileResponse, AppError> {
        return Future { promise in
            WebService.call(path: .fetchUser, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro interno no servidor")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ProfileResponse.self, from: data)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(res))
                    break
                }
            }
        }
    }
    
    func updateUser(userId: Int, request profileRequest: ProfileRequest) -> Future<ProfileResponse, AppError> {
        return Future { promise in
            let path = String(format: WebService.Endpoint.updateUser.rawValue, userId)
            WebService.call(path: path, method: .put, body: profileRequest) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro interno no servidor")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ProfileResponse.self, from: data)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(res))
                    break
                }
            }
        }
    }
    
}
