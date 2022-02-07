//
//  WorkoutHome.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 10/01/22.
//

import SwiftUI

struct WorkoutHome: View {
    
    @StateObject var viewModel = WorkoutsViewModel()
    @State var presentAddWorkoutSheet = false
    
    
    private var addButton: some View {
        Button(action: { self.presentAddWorkoutSheet.toggle() }) {
            FloatingActionButton("+") {
                print("Button tapped!")
            }
            .backgroundColor(.orange)
            .fixedSize()
            .padding()
            .font(.largeTitle)
        }
    }
    
    private func workoutRowView(workout: Workout) -> some View {
        NavigationLink(destination: WorkoutDetailsView(workout: workout)) {
            VStack(alignment: .leading) {
                Text(workout.name)
                    .font(.headline)
                Text(workout.date)
                    .font(.subheadline)
            }
            .frame(height: 100)
            .padding()
        }
    }
    
    var body: some View {
        NavigationView {
            List() {
                ForEach (viewModel.workouts) { workout in
                    workoutRowView(workout: workout)
                        .foregroundColor(Color.orange)
                }
                .onDelete() { indexSet in
                    viewModel.removeWorkouts(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("Meus Exercicios")
            .navigationBarItems(trailing: addButton)
            .onAppear() {
                print("WorkoutsListView appears WorkoutHome .")
                self.viewModel.subscribe()
            }
            
            .sheet(isPresented: self.$presentAddWorkoutSheet) {
                WorkoutEditView()
            }
        }
    }
}


struct WorkoutHome_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHome()
    }
}

