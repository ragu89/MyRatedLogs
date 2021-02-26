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
                Text("Description of your log:")
                TextEditor(text: $viewModel.description)
            }
            
            Section {
                Text("Ranking:")
                Picker(
                    "Ranking",
                    selection: $viewModel.ranking) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section {
                DatePicker(
                    "Date of the log:",
                    selection: $viewModel.date,
                    displayedComponents: .date
                ).datePickerStyle(GraphicalDatePickerStyle())
            }
        }
    }
}

struct AddLogView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddLogView(
            viewModel: AddLogViewModel(
                logFetching: LogFetcher(),
                logAddedCompletion: {
                },
                isPresented: .constant(true)
            )
        )
    }
}
