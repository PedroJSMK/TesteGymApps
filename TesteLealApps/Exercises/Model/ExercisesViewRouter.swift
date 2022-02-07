//
//  ExercisesViewRouter.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 10/01/22.
//

import SwiftUI
import Combine

enum ExercisesViewRouter {
  
    static func makeSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = SignUpViewModel(service: SignUpInteractor() as! RegistrationService)
      viewModel.publisher = publisher
      return SignUpView(viewModel: viewModel)
    }
}
