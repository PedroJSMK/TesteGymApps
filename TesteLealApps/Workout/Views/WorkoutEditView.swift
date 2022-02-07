//
//  WorkoutEditView.swift
//  TesteLealApps (iOS)
//
//  Created by Pedro on 10/01/22.
//

import SwiftUI

enum Mode {
    case new
    case edit
}

enum Action {
    case delete
    case done
    case cancel
}

struct WorkoutEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    @ObservedObject var viewModel = WorkoutViewModels()
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
    
    
    var cancelButton: some View {
        Button(action: { self.handleCancelTapped() }) {
            Text("Cancelar")
        }
    }
    
    var saveButton: some View {
        Button(action: { self.handleDoneTapped() }) {
            Text(mode == .new ? "Concluir" : "Salvar")
        }
        .disabled(!viewModel.modified)
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("Treino")) {
                    NameField
                    dataTreino
                }
                
                Section(header: Text("Detalhes")) {
                    TextField("Observações", text: $viewModel.workout.description)
                }
                
                if mode == .edit {
                    Section {
                        Button("Excluir Treino") { self.presentActionSheet.toggle() }
                        .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle(mode == .new ? "Novo Treino" : viewModel.workout.name)
            .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
            .navigationBarItems(
                leading: cancelButton,
                trailing: saveButton
            )
            .actionSheet(isPresented: $presentActionSheet) {
                ActionSheet(title: Text("Voce deseja excluir?"),
                            buttons: [
                                .destructive(Text("Excluir Treino"),
                                             action: { self.handleDeleteTapped() }),
                                .cancel()
                            ])
            }
        }
        
    }
    
    // Action Handlers
    
    func handleCancelTapped() {
        self.dismiss()
    }
    
    func handleDoneTapped() {
        self.viewModel.handleDoneTapped()
        self.dismiss()
    }
    
    func handleDeleteTapped() {
        viewModel.handleDeleteTapped()
        self.dismiss()
        self.completionHandler?(.success(.delete))
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}


struct WorkoutEditView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = Workout(name: "Sample title", description: "Sample Description", date: "2020")
        let workoutViewModel = WorkoutViewModels(workout: workout)
        return WorkoutEditView(viewModel: workoutViewModel, mode: .edit)
    }
}


extension WorkoutEditView {
    
    var NameField: some View {
        EditTextView(text: $viewModel.workout.name,
                     placeholder: "ex: Treino para emagrecer *",
                     keyboard: .numberPad,
                     error: "Escolha um nome treino!",
                     failure: viewModel.workout.name.count < 0,
                     autocapitalization: .words, sfSymbol: "")
    }
}


extension WorkoutEditView {
    var dataTreino: some View {
        EditTextView(text: $viewModel.workout.date,
                     placeholder: "Entre com com data *",
                     mask: "##/##/####",
                     keyboard: .numberPad,
                     error: "Data deve ser dd/MM/yyyy",
                     failure: viewModel.workout.date.count != 10, sfSymbol: "")
    }
}




