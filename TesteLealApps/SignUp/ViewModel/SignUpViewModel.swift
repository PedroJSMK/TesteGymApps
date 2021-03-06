
import Foundation
import Combine
import SwiftUI
import FirebaseStorage
import Firebase

enum RegistrationState {
    case successfull
    case loading
    case failed(error: Error)
    case erro(erro: String)
    case na
}


protocol RegistrationViewModel {
    func register()
    var hasError: Bool {get}
    var service: RegistrationService { get }
    var state: RegistrationState { get }
    var userDetails: RegistrationModel { get }
    init(service: RegistrationService)
}

class SignUpViewModel: ObservableObject, RegistrationViewModel {
 
        
        @Published var hasError: Bool = false
        @Published var state: RegistrationState = .na
        
        @Published var image = UIImage()
        @Published var formInvalid = false
        @Published var birthday = ""
        @Published var fullName = ""
        @Published var email = ""
        @Published var password = ""
        @Published var document = ""
        @Published var phone = ""
        @Published var gender = Gender.male
     
        private var cancellableSignUp: AnyCancellable?
        private var cancellableSignIn: AnyCancellable?
        
        @Published var uiState: RegisrationUIState = .none
    var publisher: PassthroughSubject<Bool, Never>!

        let service: RegistrationService
       
     
        var userDetails: RegistrationModel = RegistrationModel.new
        
        private var subscriptions = Set<AnyCancellable>()

    required init(service: RegistrationService) {
            self.service = service
            setupErrorSubscriptions()
        }

        func register() {
            
     
            
            func uploadPhoto() {
                let filename = UUID().uuidString
                
                guard let data = image.jpegData(compressionQuality: 0.2) else { return }
                
                let newMetadata = StorageMetadata()
                
                let ref = Storage.storage().reference(withPath: "/images/\(filename).pg")
                
                ref.putData(data, metadata: newMetadata) { metadata, err in
                    ref.downloadURL { url, error in
                        self.uiState = .successfull
                        print("foto criada \(url)")
                    }
                }
            }
            
            if(image.size.width <= 0) {
                formInvalid = true
                self.uiState = .error("Selecione uma foto")
                return
            }
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "dd/MM/yyyy"
            
            let dateFormatted = formatter.date(from: birthday)
            
            guard let dateFormatted = dateFormatted else {
                self.state = .erro(erro: "Data inv??lida \(birthday)")
                return
            }
            
            formatter.dateFormat = "yyyy-MM-dd"
            let birthday = formatter.string(from: dateFormatted)
            
            userDetails = RegistrationModel(fullName: fullName,
                                            email: email,
                                            password: password,
                                            document: document,
                                            phone: phone,
                                            birthday: birthday,
                                            gender: gender.index)
            service
                .register(with: userDetails)
                .sink { [weak self] res in
                    switch res {
                    case .failure(let error):
                        self?.state = .failed(error: error)
                    default: break
                    }
                } receiveValue: { [weak self] in
                    self?.state = .successfull
                }
                .store(in: &subscriptions)
                uploadPhoto()
            
        }
        
    }

    private extension SignUpViewModel {
        
        func setupErrorSubscriptions() {
            $state
                .map { state -> Bool in
                    switch state {
                    case .successfull,
                            .na:
                        return false
                        
                    case .failed:
                        return true
                    case .erro:
                        return true
                    case .loading:
                        return true
                    }
                }
                .assign(to: &$hasError)
        }
    }



extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}

