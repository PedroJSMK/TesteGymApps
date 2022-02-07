//
//  ExercisesViewModel.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 10/01/22.
//

import SwiftUI
import Firebase

class ExercisesViewModel: NSObject, ObservableObject {
    
    @Published var search = ""
    
    @Published var showMenu = false
    
    @Published var exercises: [Exercises] = []
    @Published var filtered: [Exercises] = []
    
    @Published var exercisesItems: [ExercisesList] = []
    @Published var dethol = false
    
    @Published var image = ""
    
    func login() {
        Auth.auth().signInAnonymously { (res, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            print("Successo = \(res!.user.uid)")
            
            // After Logging in Fetch Data
            self.fetchData()
        }
    }
    
    func fetchData() {
        let db = Firestore.firestore()
        db.collection("Exercicios").getDocuments { (snap, err) in
            guard let itemData = snap else { return }
            
            self.exercises = itemData.documents.compactMap({ (doc) -> Exercises? in
                let id = doc.documentID
                let name = doc.get("name") as! String
                let cost = doc.get("cost") as! NSNumber
                let image = doc.get("image") as! String
                let observacoes = doc.get("observacoes") as! String
                
                
                
                return Exercises(id: id,
                                 name: name,
                                 image: image,
                                 observacoes: observacoes,
                                 cost: cost)
            })
            
            self.filtered = self.exercises
        }
    }
    
    // Search or Filter
    func filterData() {
        withAnimation(.linear) {
            self.filtered = self.exercises.filter {
                return $0.name.lowercased().contains(self.search.lowercased())
                
            }
        }
    }
    
    func addToWorkout(item: Exercises) {
        
        
        self.exercises[getIndex(item: item, exercisesIndex: false)].isAdded = !item.isAdded
        // Update filtered array also for search bar results
        let filterIndex = self.filtered.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
        
        self.filtered[filterIndex].isAdded = !item.isAdded
        
        if item.isAdded {
            // Remove list
            self.exercisesItems.remove(at: getIndex(item: item, exercisesIndex: true))
            return
        }
        // else add
        self.exercisesItems.append(ExercisesList(item: item, quantity: 1))
        
        
    }
    
    func getIndex(item: Exercises, exercisesIndex: Bool) -> Int {
        let index = self.exercises.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
        
        let workoutsndex = self.exercisesItems.firstIndex { (item1) -> Bool in
            return item.id == item1.item.id
        } ?? 0
        
        return exercisesIndex ? workoutsndex : index
    }
    
    
    
    // Writing Data into Firestore
    func updateDethol() {
        let db = Firestore.firestore()
        
        // Create details
        if dethol {
            dethol = false
            db.collection("Users").document(Auth.auth().currentUser!.uid).delete {
                (err) in
                if err != nil {
                    self.dethol = true
                }
            }
            
            return
        }
        
        var details: [[String: Any]] = []
        
        exercisesItems.forEach { (exercises) in
            details.append([
                "name": exercises.item.name,
                "quantity": exercises.quantity,
                "cost": exercises.item.cost
            ])
        }
        
        dethol = true
        
        db.collection("Users").document(Auth.auth().currentUser!.uid).setData([
            "exercises_selected": details
            
        ]) { (err) in
            if err != nil {
                self.dethol = false
                return
            }
            print("success")
        }
    }
}
