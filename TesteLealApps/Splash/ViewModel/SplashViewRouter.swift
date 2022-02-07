//
//  SplashViewRouter.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//

import SwiftUI

enum SplashViewRouter {
  
  static func makeSignInView() -> some View {
    let viewModel = SignInViewModel(interactor: SignInInteractor())
    return SignInView(viewModel: viewModel)
  }
  
    static func makeHomeView() -> some View {
      let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
