//
//  Menu.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro  on 13/01/22
//

import SwiftUI

struct Menu: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    
    @State private var isShowingDetailView = false
    
    var body: some View {
        VStack {
            
            
            NavigationLink(destination:  ExercisesSelect(viewModel: viewModel), isActive: $isShowingDetailView) { EmptyView() }
            HStack(spacing: 15) {
                Image(systemName: "goforward.plus")
                    .font(.title2)
                    .foregroundColor(.orange)
            }
            
            Button("Ver exercicios selecionados") {
                self.isShowingDetailView = true
                
            }
            .padding()
            
            Spacer()
            
            HStack {
                Spacer()
                
            }
            .padding(10)
            
        }
        .padding([.top, .trailing])
        .frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color.blue.ignoresSafeArea())
        .accentColor(Color.orange)
    }
    
}


extension Menu {
    func goToExercisesViewModel() -> some View {
        return SignInViewRouter.MakegoToExercisesViewModel()
    }
}
