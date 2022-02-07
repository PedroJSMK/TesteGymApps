////
////  AuthService.swift
////  TesteLealApps (iOS)
////
////  Created by Pedro on 11/01/22.
////
//
//import Firebase
//import Combine
//
//class AuthService: ObservableObject {
//    
//    @Published var uiState: SignUpUIState = .none
//    
//     
////    @Published var image = UIImage()
//    @Published var fullName = ""
//    @Published var email = ""
//    @Published var password = ""
//    @Published var document = ""
//    @Published var phone = ""
//    @Published var birthday = ""
//    @Published var gender = Gender.male
//    
//    
//    func currentUserUid() -> String? {
//        Auth.auth().currentUser?.uid
//    }
//    
//    public static func logout() -> Future<Bool, Error> {
//        return Future<Bool, Error> { completion in
//            do {
//                try Auth.auth().signOut()
//                completion(.success(true))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//    }
//    
//    func signIn(withEmail email: String, password: String) -> Future<AuthDataResult, Error> {
//        self.uiState = .loading
//        
//        return Future<AuthDataResult, Error> { completion in
//            if Auth.auth().currentUser == nil {
//                Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
//                    if let error = error {
//                        completion(.failure(error))
//                        return
//                    }
//                    guard let authDataResult = authDataResult else {
//                        completion(.failure(FirebaseError.noAuthDataResult))
//                        return
//                    }
//                    completion(.success(authDataResult))
//                }
//            } else {
//                completion(.failure(FirebaseError.alreadySignedIn))
//            }
//        }
//    }
//    
//    func signUp(withEmail email: String, password: String) -> Future<AuthDataResult, Error> {
//        self.uiState = .loading
//        
//        
//        
//        return Future<AuthDataResult, Error> { completion in
//            if Auth.auth().currentUser == nil {
//                Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
//                    if let error = error {
//                        completion(.failure(error))
//                        return
//                    }
//                    guard let authDataResult = authDataResult else {
//                        completion(.failure(FirebaseError.noAuthDataResult))
//                        return
//                    }
//                    completion(.success(authDataResult))
//                }
//            } else {
//                completion(.failure(FirebaseError.alreadySignedIn))
//            }
//            
//        }
//        
//    }
//    
//    public static func sendResetPassword(toEmail email: String) -> Future<Bool, Error> {
//        return Future<Bool, Error> { completion in
//            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//                completion(.success(true))
//            }
//        }
//    }
//    
//    public static func updateEmail(to email: String) -> Future<Bool, Error> {
//        return Future<Bool, Error> { completion in
//            Auth.auth().currentUser?.updateEmail(to: email, completion: { error in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//                completion(.success(true))
//            })
//        }
//    }
//    
//    public static func updatePassword(to password: String) -> Future<Bool, Error> {
//        return Future<Bool, Error> { completion in
//            Auth.auth().currentUser?.updatePassword(to: password, completion: { error in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//                completion(.success(true))
//            })
//        }
//    }
//    
//    public static func updatePhone(to phoneNumber: PhoneAuthCredential) -> Future<Bool, Error> {
//        return Future<Bool, Error> { completion in
//            Auth.auth().currentUser?.updatePhoneNumber(phoneNumber, completion: { error in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//                completion(.success(true))
//            })
//        }
//    }
//    
//}
