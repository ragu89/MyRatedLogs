//
//  LogDetailView.swift
//  MyRatedLogs
//
//  Created by Guye Raphael, I233 on 11.02.21.
//

import SwiftUI

struct LogDetailView: View {
    
    @ObservedObject var viewModel: LogDetailViewModel
    
    init(viewModel: LogDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .onAppear(perform: {
                viewModel.viewOnAppear()
            })
    }
    
    private var content: some View {
        if viewModel.fetchedLog == nil {
            return AnyView(ProgressView("Loading log"))
        } else {
            return AnyView(
                VStack {
                    Text(viewModel.fetchedLog!.dateFormatted)
                    Text(viewModel.fetchedLog!.description)
                    Text("Ranking: \(viewModel.fetchedLog!.ranking)")
                }
            )
        }
    }
}

struct LogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LogDetailView(
            viewModel: LogDetailViewModel(
                logId: "42",
                logFetching: MockLogFetching()
            )
        )
    }
}
