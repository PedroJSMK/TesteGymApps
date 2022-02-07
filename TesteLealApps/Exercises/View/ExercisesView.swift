//
//  ExercisesView.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 10/01/22.
//

import SwiftUI
import Firebase

struct ExercisesView: View {
    
    @StateObject var viewModel = ExercisesViewModel()
    
    @State var presentAddWorkoutSheet = false
    
    private var addButton: some View {
        Button(action: { self.presentAddWorkoutSheet.toggle() }) {
            Image(systemName: "plus")
        }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack(spacing: 15) {
                    Button(action: {
                        withAnimation(.easeIn){viewModel.showMenu.toggle()}
                    }, label: {
                        Image(systemName: "plus.square.on.square")
                            .font(.title2)
                            .foregroundColor(.orange)
                    })
                    
                    Spacer(minLength: 0)
                }
                .padding([.horizontal, .top])
                
                Divider()
                
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass.circle")
                        .font(.title2)
                        .foregroundColor(.orange)
                    buscarField
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Divider()
                
                if viewModel.exercises.isEmpty {
                    Spacer()
                    
                    ProgressView()
                    
                    Spacer()
                } else {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        VStack(spacing: 25) {
                            ForEach(viewModel.filtered) { item in
                                ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                    ExercisesItemView(item: item)
                                    HStack {
                                        Text(item.name)
                                            .foregroundColor(.orange)
                                        Spacer(minLength: 0)
                                            .padding(10)
                                        Button(action:  {
                                            viewModel.addToWorkout(item: item)
                                        }, label: {
                                            Image(systemName: item.isAdded ? "checkmark" : "plus")
                                                .foregroundColor(.red)
                                                .padding(10)
                                                .background(item.isAdded ? Color.green : Color("orange"))
                                                .clipShape(Circle())
                                        })
                                    }
                                    .padding(.trailing, 10)
                                    .padding(.top, 10)
                                })
                                    .frame(width: UIScreen.main.bounds.width - 30)
                            }
                        }
                        .padding(.top, 10)
                    })
                }
            }
            
            // Side Menu
            HStack {
                Menu(viewModel: viewModel)
                    .offset(x: viewModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                Spacer(minLength: 0)
            }
            .background(
                Color.black.opacity(viewModel.showMenu ? 0.3 : 0).ignoresSafeArea()
                    .onTapGesture(perform: {
                        withAnimation(.easeIn){viewModel.showMenu.toggle()}
                    })
            )
        }
        
        .onAppear() {
            print("WorkoutsListView appears ExercisesView.")
            self.viewModel.fetchData()
            
        }
        .onChange(of: viewModel.search, perform: { value in
            //search requests
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if value == viewModel.search && viewModel.search != "" {
                    // Search Data
                    viewModel.filterData()
                }
            }
            if viewModel.search == "" {
                // Reset data
                withAnimation(.linear) {viewModel.filtered = viewModel.exercises}
            }
        })
    }
}

extension ExercisesView {
    var buscarField: some View {
        EditTextView(text: $viewModel.search,
                     placeholder: "Buscar",
                     keyboard: .alphabet,
                     error: "Deve ter mais de 1 caracteres", sfSymbol: "")
    }
}
    

extension ExercisesView {
    var imageBD: some View {
        VStack{
            EditTextView(text: $viewModel.image, sfSymbol: "")
            //.resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("white"), lineWidth: 4))
                .shadow(radius: 7)
        }
    }
}
