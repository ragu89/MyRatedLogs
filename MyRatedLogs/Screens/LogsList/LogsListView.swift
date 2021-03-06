//
//  LogsListView.swift
//  MyRatedLogs
//
//  Created by Guye Raphael, I233 on 10.02.21.
//

import SwiftUI

struct LogsListView: View {
    
    @ObservedObject var viewModel: LogsListViewModel
    
    init(viewModel: LogsListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("My Rated logs")
                .navigationBarItems(
                    trailing: Button("Add") {
                        viewModel.isAddLogViewDisplayed = true
                    }
                )
                .sheet(
                    isPresented: $viewModel.isAddLogViewDisplayed,
                    onDismiss: {
                        viewModel.isAddLogViewDisplayed = false
                    },
                    content: {
                        AddLogView(
                            viewModel: AddLogViewModel(
                                logFetching: viewModel.logFetching,
                                logAddedCompletion: {
                                    viewModel.onLogAdded()
                                },
                                isPresented: $viewModel.isAddLogViewDisplayed)
                        )
                    }
                )
        }
        .onAppear(perform: {
            viewModel.viewOnAppear()
        })
    }
    
    var content: some View {
        if viewModel.isLoading == true {
            return AnyView(ProgressView("Loading"))
        } else {
            return AnyView(Form {
                Section {
                    if viewModel.logs.isEmpty {
                        Text("No logs")
                    } else {
                        ForEach(viewModel.logs, id: \.description) { log in
                            NavigationLink(
                                log.description,
                                destination: LogDetailView(
                                    viewModel: LogDetailViewModel(
                                        logId: log.id,
                                        logFetching: viewModel.logFetching)
                                )
                            )
                        }
                        .onDelete(perform: {
                            self.viewModel.delete(at: $0)
                        })
                    }
                }
            })
        }
    }
}

struct LogsListView_Previews: PreviewProvider {
    static var previews: some View {
        LogsListView(
            viewModel: LogsListViewModel(
                logFetching: LogFetcher()
            )
        )
    }
}
