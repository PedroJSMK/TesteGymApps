//
//  WorkoutDetailsView.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 10/01/22.
//

import SwiftUI

struct WorkoutDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditWorkoutSheet = false
    
    var workout: Workout
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Editar")
        }
    }
    
    private func addExercisesButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Add")
        }
    }
    
    
    var body: some View {
        Form {
            Section(header: Text("Exercicios")) {
                Text(workout.name)
                Text(workout.description)
                
            }
            
            Section(header: Text("Data")) {
                Text(workout.date)
            }
        }
        
        .navigationBarTitle(workout.name)
        .navigationBarItems(trailing: editButton {
            self.presentEditWorkoutSheet.toggle()
        })
        .onAppear() {
            print("WorkoutDetailsView.onAppear() for \(self.workout.name)")
        }
        .onDisappear() {
            print("WorkoutDetailsView.onDisappear()")
        }
        .sheet(isPresented: self.$presentEditWorkoutSheet) {
            WorkoutEditView(viewModel: WorkoutViewModels(workout: workout), mode: .edit) { result in
                if case .success(let action) = result, action == .delete {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        
        addExercises
        
    }
}

extension WorkoutDetailsView {
    var addExercises: some View {
        
        VStack {
            NavigationLink(destination: ExercisesSelection()) {
                
                FloatingActionButton("+") {
                    print("Button tapped!")
                }
                .backgroundColor(.orange)
                .fixedSize()
                .padding()
                .font(.largeTitle)
            }
            
            .navigationTitle("Navigation")
            .navigationBarItems(trailing: addExercisesButton {
                self.presentEditWorkoutSheet.toggle()
                
            })
        }
    }
}

