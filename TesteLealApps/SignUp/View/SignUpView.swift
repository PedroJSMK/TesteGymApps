//
//  SignUpView.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//
 
import SwiftUI
import Firebase


    struct SignUpView: View {
        
//        @ObservedObject private var viewModel = SignUpViewModel(
//            service: RegistrationServiceImpl()
//        )
        @ObservedObject var viewModel: SignUpViewModel

        var backgroundImage: some View{
            Image("splash")
                .resizable()
                .aspectRatio(
                    contentMode: .fill
                ).overlay(Color.black.opacity(0.05))
        }
        
        @State var isShowPhotolibrary = false
        
        var body: some View {
            GeometryReader{ proxy in
                
                ZStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .center) {
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text("Cadastro")
                                    .foregroundColor(Color("textColor"))
                                    .font(Font.system(.title).bold())
                                    .padding(.bottom, 8)
                                
                                Photo
                                
                                fullNameField
                                
                                emailField
                                
                                passwordField
                                
                                documentField
                                
                                phoneField
                                
                                birthdayField
                                
                                genderField
                                
                                // saveButton
                                
                            }
                            
                            Spacer()
                        }.padding(.horizontal, 8)
                        saveButton
                    }.padding()
                    
                        .applyClose()
                    
                }
                .background(
                    backgroundImage.frame(width:proxy.size.width)
                        .edgesIgnoringSafeArea(.all)
                )
                
                if case RegisrationUIState.error(let value) = viewModel.uiState {
                    Text("")
                        .alert(isPresented: .constant(true)) {
                            Alert(title: Text("titulo"), message: Text(value), dismissButton: .default(Text("Ok")) {
                                // faz algo quando some o alerta
                            })
                        }
                }
            }
        }
    }

    extension SignUpView {
        var Photo: some View {
            VStack{
                Button {
                    isShowPhotolibrary = true
                } label: {
                    if viewModel.image.size.width > 20 {
                        Image(uiImage: viewModel.image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color("black"), lineWidth: 2.4))
                            .shadow(radius: 7)
                            .foregroundColor(Color.black)
                            .cornerRadius(100.0)
                        
                    } else {
                        Text("Selecione um Foto")
                            .frame(width: 100, height: 100)
                            .padding()
                            .overlay( Circle().stroke(Color.blue, lineWidth: 2.0))
                            .background()
                            .foregroundColor(Color.blue)
                            .cornerRadius(100.0)
                    }
                }
                .padding(.bottom, 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                
                .sheet(isPresented: $isShowPhotolibrary) {
                    ImagePicker(selectedImage: $viewModel.image)
                }
            }
        }
    }


    extension SignUpView {
        var emailField: some View {
            EditTextView(text: $viewModel.email,
                         placeholder: "Entre com seu e-mail *",
                         keyboard: .emailAddress,
                         error: "E-mail inv??lido",
                         failure: !viewModel.email.isEmail(),
                         sfSymbol: "mail")
        }
    }

    extension SignUpView {
        var passwordField: some View {
            InputPasswordView(password: $viewModel.password,
                              placeholder: "Senha",
                              sfSymbol: "lock")
            
        }
    }

    extension SignUpView {
        var fullNameField: some View {
            EditTextView(text: $viewModel.fullName,
                         placeholder: "Entre com seu nome completo *",
                         keyboard: .alphabet,
                         error: "Nome deve ter mais de 3 caracteres",
                         failure: viewModel.fullName.count < 3,
                         autocapitalization: .words,
                         sfSymbol: "envelope")
        }
    }

    extension SignUpView {
        var documentField: some View {
            EditTextView(text: $viewModel.document,
                         placeholder: "Entre com seu CPF *",
                         mask: "###.###.###-##",
                         keyboard: .numberPad,
                         error: "CPF inv??lido",
                         failure: viewModel.document.count != 14,
                         sfSymbol: "doc.plaintext")
        }
    }

    extension SignUpView {
        var phoneField: some View {
            EditTextView(text: $viewModel.phone,
                         placeholder: "Entre com seu celular *",
                         mask: "(##) ####-####",
                         keyboard: .numberPad,
                         error: "Entre com o DDD + 8 ou 9 digitos",
                         failure: viewModel.phone.count < 14 || viewModel.phone.count > 15,
                         sfSymbol: "phone")
        }
    }

    extension SignUpView {
        var birthdayField: some View {
            EditTextView(text: $viewModel.birthday,
                         placeholder: "Entre com com sua data de nascimento *",
                         mask: "##/##/####",
                         keyboard: .numberPad,
                         error: "Data deve ser dd/MM/yyyy",
                         failure: viewModel.birthday.count != 10,
                         sfSymbol: "hands.sparkles")
        }
    }

    extension SignUpView {
        var genderField: some View {
            Picker("Gender", selection: $viewModel.gender) {
                ForEach(Gender.allCases, id: \.self) { value in
                    Text(value.rawValue)
                        .tag(value)
                }
            }.pickerStyle(SegmentedPickerStyle())
                .padding(.top, 16)
                .padding(.bottom, 32)
        }
    }

    extension SignUpView {
        var saveButton: some View {
            
            RegisterButtonView(action: {
                viewModel.register()
            },
                               text: "Realize o seu Cadastro",
                               showProgress: self.viewModel.uiState == RegisrationUIState.loading,
                               disabled: !viewModel.email.isEmail() ||
                               viewModel.password.count < 8 ||
                               viewModel.fullName.count < 3 ||
                               viewModel.document.count != 14 ||
                               viewModel.phone.count < 14 || viewModel.phone.count > 15 ||
                               viewModel.birthday.count != 10)
        }
    }

    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            ForEach(ColorScheme.allCases, id: \.self) {
                SignUpView(viewModel: SignUpViewModel(service: SignUpInteractor() as! RegistrationService))
                    .previewDevice("iPhone 11")
                    .preferredColorScheme($0)
            }
            
        }
    }

 
