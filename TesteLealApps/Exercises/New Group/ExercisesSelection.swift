//
//  ExercisesSelection.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 15/01/22.
//

import SwiftUI
import Firebase

struct ExercisesSelection: View {
    
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
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 5) {
                        ForEach(viewModel.filtered) { item in
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                ExercisesItemView(item: item)
                                HStack {
                                    
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
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                    }
                    .padding(.top, 10)
                })
            }
            
            
            
            VStack {
                MenuWorkout(viewModel: viewModel)
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


extension ExercisesSelection {
    var imageBD: some View {
        VStack{
            
            EditTextView(text: $viewModel.image, sfSymbol: "")
            //.resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("white"), lineWidth: 4))
                .shadow(radius: 7)
        }
    }
}
