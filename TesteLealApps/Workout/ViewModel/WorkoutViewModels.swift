//
//  WorkoutViewModels.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 10/01/22.
//

import Foundation
import Combine
import FirebaseFirestore

class WorkoutViewModels: ObservableObject {
    
    @Published var workout: Workout
    @Published var modified = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(workout: Workout = Workout(name: "", description: "", date: "")) {
        self.workout = workout
        
        self.$workout
            .dropFirst()
            .sink { [weak self] workout in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    
    private var db = Firestore.firestore()
    
    private func addWorkout(_ workout: Workout) {
        do {
            let _ = try db.collection("treino").addDocument(from: workout)
        }
        catch {
            print(error)
        }
    }
    
    private func updateWorkout(_ workout: Workout) {
        if let documentId = workout.id {
            do {
                try db.collection("treino").document(documentId).setData(from: workout)
            }
            catch {
                print(error)
            }
        }
    }
    
    private func updateOrAddWorkout() {
        if let _ = workout.id {
            self.updateWorkout(self.workout)
        }
        else {
            addWorkout(workout)
        }
    }
    
    private func removeWorkout() {
        if let documentId = workout.id {
            db.collection("treino").document(documentId).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // UI handlers
    
    func handleDoneTapped() {
        self.updateOrAddWorkout()
    }
    
    func handleDeleteTapped() {
        self.removeWorkout()
    }
    
}



