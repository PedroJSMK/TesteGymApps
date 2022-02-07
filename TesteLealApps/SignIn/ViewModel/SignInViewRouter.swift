//
//  SignInViewRouter.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//

import SwiftUI
import Combine

enum SignInViewRouter {
    
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
    static func makeSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View {
         let viewModel = SignUpViewModel(service: RegistrationServiceImpl())
        viewModel.publisher = publisher
        return SignUpView(viewModel: viewModel)
    }
    
   
    static func MakegoToExercisesViewModel() -> some View {
        let viewModel = ExercisesViewModel()
        return ExercisesSelect(viewModel: viewModel)
    }
}
