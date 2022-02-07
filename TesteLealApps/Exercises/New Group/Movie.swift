//
//  Movie.swift
//  filmes
//
//  Created by Pedro Kanagusto on 10/01/22.
//

import Foundation
import Foundation
import FirebaseFirestoreSwift
 
struct Movie: Identifiable, Codable {
  @DocumentID var id: String?
  var title: String
  var description: String
  var year: String
   
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case description
    case year
  }
}
