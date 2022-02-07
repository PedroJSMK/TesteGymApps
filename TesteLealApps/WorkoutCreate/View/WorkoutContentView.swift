//
//  WorkoutContentView.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 10/01/22.
//

import SwiftUI

struct WorkoutContentView: View {
    typealias UserId = String
    
    
    @StateObject var viewModel = WorkoutsViewModel()
    @State var presentAddWorkoutSheet = false
    
    
    private var addButton: some View {
        Button(action: { self.presentAddWorkoutSheet.toggle() }) {
            Image(systemName: "plus")
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
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach (viewModel.workouts) { workout in
                    workoutRowView(workout: workout)
                }
                
                .onDelete() { indexSet in
                    viewModel.removeWorkouts(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("Meus Treinos")
            .navigationBarItems(trailing: addButton)
            .onAppear() {
                print("WorkoutsListView appears. .")
                self.viewModel.subscribe()
            }
            .sheet(isPresented: self.$presentAddWorkoutSheet) {
                WorkoutEditView()
            }
        }
    }
}

struct WorkoutContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutContentView()
    }
}
