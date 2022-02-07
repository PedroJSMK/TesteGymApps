//
//  Workout.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 10/01/22.
//

import Foundation
import FirebaseFirestoreSwift
 
struct Workout: Identifiable, Codable {
  @DocumentID var id: String?
  var name: String
  var description: String
  var date: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case date
  }
}
