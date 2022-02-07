//
//  SignInUIState.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro Kanagusto on 06/01/22.
//

import Foundation

enum SignInUIState: Equatable {
  case none
  case loading
  case goToHomeScreen
  case error(String)
}
