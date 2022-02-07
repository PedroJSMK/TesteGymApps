//
//  FirebaseAppError.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 10/01/22.
//

import Foundation

enum FirebaseAppError:LocalizedError {
    case auth(description: String)
    case `default` (description:String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .auth(description):
            return description
        case let .default(description):
            return description ?? "something went wrong"
        }
    }
}
