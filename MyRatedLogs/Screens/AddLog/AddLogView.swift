//
//  AddLogView.swift
//  MyRatedLogs
//
//  Created by Guye Raphael, I233 on 26.02.21.
//

import SwiftUI

struct AddLogView: View {
    
    @ObservedObject private var viewModel: AddLogViewModel
    
    init(viewModel: AddLogViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Add Log")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: Button("Cancel") {
                        viewModel.cancel()
                    },
                    trailing: Button("Save") {
                        viewModel.saveLog()
                    }
                )
        }
    }
    
    var content: some View {
        Form {
            Section {
                TextEditor(text: .constant("Description of the entry"))
            }
            
            Section {
                
                Button("Select a Date") {
                }.disabled(true)
                
                TextField("Ranking", text: $viewModel.ranking)
            }
        }
    }
}

struct AddLogView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddLogView(viewModel: AddLogViewModel(
            isPresented: .constant(true)
        ))
    }
}
