//
//  SplashView.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 06/01/22.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group {
            switch viewModel.uiState {
            case .loading:
                loadingView()
            case .goToSignInScreen:
                viewModel.signInView()
            case .goToHomeScreen:
                viewModel.homeView()
            case .error(let msg):
                loadingView(error: msg)
            }
        }.onAppear(perform: viewModel.onAppear)
    }
    
}

extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack {
            Image("splash")
                .resizable()
                .aspectRatio(
                    contentMode: .fill
                ).overlay(Color.black.opacity(0.4))
            
            
            
            
            
            //   .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            //  .padding(20)
                .ignoresSafeArea()
            
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Teste"), message: Text(error), dismissButton: .default(Text("Ok")) {
                         })
                    }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            let viewModel = SplashViewModel(interactor: SplashInteractor())
            SplashView(viewModel: viewModel)
                .previewDevice("iPhone 11")
                .preferredColorScheme($0)
        }
    }
}

