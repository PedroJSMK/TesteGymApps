//
//  WorkoutsViewModel.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 10/01/22.
//

import Foundation
import Combine
import FirebaseFirestore

class WorkoutsViewModel: ObservableObject {
    @Published var workouts = [Workout]()
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    deinit {
        unsubscribe()
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func subscribe() {
        if listenerRegistration == nil {
            listenerRegistration = db.collection("treino").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.workouts = documents.compactMap { queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: Workout.self)
                }
            }
        }
    }
    
    func removeWorkouts(atOffsets indexSet: IndexSet) {
        let workouts = indexSet.lazy.map { self.workouts[$0] }
        workouts.forEach { workout in
            if let documentId = workout.id {
                db.collection("Treino").document(documentId).delete { error in
                    if let error = error {
                        print("Unable to remove document: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
