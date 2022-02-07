//
//  HomeView.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            
            viewModel.workoutView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Treinos")
                }.tag(0)
            
            viewModel.ExercisesView()
                .tabItem {
                    Image(systemName: "heart.text.square.fill")
                    Text("Exercícios")
                }.tag(1)
            
            
            viewModel.profileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Perfil")
                }.tag(2)
            
            
             
        }
        
    }
    
}

 








struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
