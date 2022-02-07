//
//  ExercisesSelect.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 13/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExercisesSelect: View {
    
    @ObservedObject var viewModel: ExercisesViewModel
    
    @Environment(\.presentationMode) var present
    
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Button(action: {present.wrappedValue.dismiss()}) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(Color.orange)
                }
                
                Text("Meus Exercicios")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.exercisesItems){ exercises in
                        //  ItemView
                        HStack(spacing: 15) {
                            WebImage(url: URL(string: exercises.item.image))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 130)
                                .cornerRadius(15)
                        }
                        HStack(spacing: 15) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(exercises.item.name)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                
                                Text(exercises.item.observacoes)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                    .lineLimit(50)
                                
                                HStack(spacing: 15) {
                                    
                                    Spacer(minLength: 0)
                                    
                                    // Add - Sub Button
                                    Button(action: {
                                        if exercises.quantity > 1 {
                                            viewModel.exercisesItems[viewModel.getIndex(item: exercises.item, exercisesIndex: true)].quantity -= 1
                                        }
                                    }) {
                                        Image(systemName: "minus")
                                            .font(.system(size: 16, weight: .heavy))
                                            .foregroundColor(.black)
                                    }
                                    
                                    Text("\(exercises.quantity)")
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 10)
                                        .background(Color.black.opacity(0.06))
                                    
                                    Button(action: {
                                        viewModel.exercisesItems[viewModel.getIndex(item: exercises.item, exercisesIndex: true)].quantity += 1
                                    }) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 16, weight: .heavy))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                        .padding()
                        .contentShape(RoundedRectangle(cornerRadius: 15))
                        .contextMenu {
                            //  deleting
                            Button(action: {
                                // Deleting items from exercises
                                let index = viewModel.getIndex(item: exercises.item, exercisesIndex: true)
                                let itemIndex = viewModel.getIndex(item: exercises.item, exercisesIndex: false)
                                let filterIndex = viewModel.filtered.firstIndex {
                                    (item1) -> Bool in
                                    return exercises.item.id == item1.id
                                } ?? 0
                                
                                viewModel.exercises[itemIndex].isAdded = false
                                viewModel.filtered[filterIndex].isAdded = false
                                
                                viewModel.exercisesItems.remove(at: index)
                                
                                
                            }) {
                                Text("Remover")
                            }
                        }
                    }
                    
                    
                }
            }
            
            // Bottom View
            VStack {
                HStack {
                    Text("Adicionar exercicios aos treinos")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding([.top, .horizontal])
                
                Button(action: viewModel.updateDethol) {
                    Text(viewModel.dethol ? "Cancelar" : "Confirmar")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(
                            Color(.orange)
                        )
                        .cornerRadius(15)
                }
                
            }
            .background(Color.white)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

