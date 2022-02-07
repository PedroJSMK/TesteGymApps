//
//  TesteLealApssError.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 08/01/22.
//

import Foundation

enum TesteLealApssError:LocalizedError {
    case auth(description: String)
    case `default` (description:String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .auth(description):
            return description
        case let .default(description):
        return description ?? "Algum erro!"
    }
}
}
