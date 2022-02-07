//
//  SignUpViewRouter.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//

import SwiftUI
import Combine

enum SignUpViewRouter {
  
  static func makeHomeView() -> some View {
    let viewModel = HomeViewModel()
    return HomeView(viewModel: viewModel)
  }
  
}
