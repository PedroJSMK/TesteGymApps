//
//  TesteLealAppsApp.swift
//  Shared
//
//  Created by Pedro on 05/01/22.
//

import SwiftUI
import Firebase

@main
struct TesteLealAppsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        
        WindowGroup {
            SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}
