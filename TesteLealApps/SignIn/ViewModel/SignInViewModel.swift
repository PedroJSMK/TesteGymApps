//
//  SignInViewModel.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//

import SwiftUI
import Combine
import FirebaseAuth
import Firebase

class SignInViewModel: ObservableObject {
    
    @Published var formInvalid = false
    var alertText = ""
    
    @Published var email = ""
    @Published var password = ""
    
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    
    private let publisher = PassthroughSubject<Bool, Never>()
    private let interactor: SignInInteractor
    
    @Published var uiState: SignInUIState = .none
    
    init(interactor: SignInInteractor) {
        self.interactor = interactor
        
        cancellable = publisher.sink { value in
            print("usuário criado! goToHome: \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    
    
    
    
    func login() {
        self.uiState = .loading
        
        func signIn(withEmail email: String, password: String) -> Future<AuthDataResult, Error> {
            return Future<AuthDataResult, Error> { completion in
                if Auth.auth().currentUser == nil {
                    Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        guard let authDataResult = authDataResult else {
                            completion(.failure(FirebaseError.noAuthDataResult))
                            return
                        }
                        completion(.success(authDataResult))
                    }
                } else {
                    completion(.failure(FirebaseError.alreadySignedIn))
                }
            }
        }
        
        //      print("email: \(email), senha: \(password)")
        //
        //      Auth.auth().signIn(withEmail: email, password: password) {
        //          result, err in
        //          guard let user = result?.user, err == nil else {
        //              self.formInvalid = true
        //              self.alertText = err!.localizedDescription
        //              print(err)
        //              return
        //          }
        // print("Usuario logado \(user.uid)")
        self.uiState = .goToHomeScreen
        
    }
    
}




extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}
