//
//  ErrorResponse.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//

import Foundation

struct ErrorResponse: Decodable {
  let detail: String
  
  enum CodingKeys: String, CodingKey {
    case detail
  }
}

