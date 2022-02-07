//
//  ProfileUIState.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 07/01/22
//

import Foundation

enum ProfileUIState: Equatable {
    case none
    case loading
    case fetchSuccess
    case fetchError(String)
    
    case updateLoading
    case updateSuccess
    case updateError(String)
    case logout
    
}
