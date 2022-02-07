//
//  SignInErrorResponse.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro Kanagusto on 06/01/22.
//

import Foundation

struct SignInErrorResponse: Decodable {
    
    let detail: SignInDetailErrorResponse
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
    
}

struct SignInDetailErrorResponse: Decodable {
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
    
}
