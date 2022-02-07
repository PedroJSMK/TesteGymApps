//
//  MenuWorkout.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 15/01/22.
//

import SwiftUI

struct MenuWorkout: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    
    @State private var isShowingDetailView = false
    
    private func addExercisesButton(action: @escaping () -> Void) -> some View {
        Button(action: { self.isShowingDetailView.toggle() }) {
            
            Image(systemName: "checkmark.circle")
                .foregroundColor(.orange)
                .fixedSize()
                .padding()
                .font(.largeTitle)
        }
        
    }
    
    var body: some View {
        
        VStack{
            NavigationLink(destination:  ExercisesSelect(viewModel: viewModel), isActive: $isShowingDetailView) { EmptyView() }
            .foregroundColor(.orange)
            
            HStack(spacing: 30) {
                
            }
            
            .padding()
            .foregroundColor(.orange)
            .navigationTitle("Exercicios")
            .navigationBarItems(trailing: addExercisesButton {
                self.isShowingDetailView.toggle()
            })
            
        }
        
        .padding()
        Spacer()
    }
}

extension MenuWorkout {
    func goToExercisesViewModel() -> some View {
        return SignInViewRouter.MakegoToExercisesViewModel()
    }
}
