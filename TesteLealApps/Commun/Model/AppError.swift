//
//  AppError.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//

import Foundation

enum AppError: Error {
  case response(message: String)
  
  public var message: String {
    switch self {
      case .response(let message):
        return message
    }
  }
}
