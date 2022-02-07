//
//  HomeViewModel.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let workoutViewModell = WorkoutHome(viewModel: WorkoutsViewModel())
    
    let exercisesViewModel = TesteLealApps.ExercisesView(viewModel: ExercisesViewModel())
    
    let profileViewModel = ProfileViewModel(interactor: ProfileInteractor())
     
    
}


extension HomeViewModel {
    func workoutView() -> some View {
        return HomeViewRouter.makeWorkoutView(viewModel: WorkoutsViewModel())
    }
    
    func ExercisesView() -> some View {
        NavigationView {
          //  ExercisesViewModel()
              //  .navigationBarHidden(true)
              //  .navigationBarBackButtonHidden(true)
      //  }
        return HomeViewRouter.makeExercisesView(viewModel: ExercisesViewModel())
              .navigationBarHidden(true)
              .navigationBarBackButtonHidden(true)
        }}
    
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
    }
}


