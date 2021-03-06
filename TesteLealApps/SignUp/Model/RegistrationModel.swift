//
//  SignUpUIState.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//

import Foundation
import UIKit

struct RegistrationModel: Encodable {

    var fullName: String
    var email: String
    var password: String
    var document: String
    var phone: String
    var birthday: String
    var gender: Int
     
}

extension RegistrationModel {
    
   static var new: RegistrationModel {
       RegistrationModel(
                        fullName: "",
                         email: "",
                         password: "",
                          document: "",
                          phone: "",
                          birthday: "",
                          gender: 1)
       
        
 
    }
}
