//
//  ContentView.swift
//  MyRatedLogs
//
//  Created by Guye Raphael, I233 on 10.02.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LogsListView(
            viewModel: LogsListViewModel(
                logFetching: MockLogFetching()
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
