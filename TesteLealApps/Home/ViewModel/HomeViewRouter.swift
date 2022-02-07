//
//  HomeViewRouter.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
  
   static func makeWorkoutView(viewModel: WorkoutsViewModel) -> some View {
     return WorkoutHome(viewModel: viewModel)
      
   }
    static func makeProfileView(viewModel:  ProfileViewModel) -> some View {
        return ProfileView(viewModel: viewModel)
    }
    
    static func makeExercisesView(viewModel:  ExercisesViewModel) -> some View {
        return ExercisesView(viewModel: viewModel)
    }
    
}

