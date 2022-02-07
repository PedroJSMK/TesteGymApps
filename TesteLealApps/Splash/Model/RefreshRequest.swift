//
//  RefreshRequest.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//

import Foundation

struct RefreshRequest: Encodable {
    
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
    }
    
}
