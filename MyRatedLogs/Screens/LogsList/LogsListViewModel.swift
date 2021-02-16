//
//  LogsListViewModel.swift
//  MyRatedLogs
//
//  Created by Guye Raphael, I233 on 10.02.21.
//

import Foundation
import Combine

class LogsListViewModel : ObservableObject {
    
    @Published var logs = [Log]()
    var cancellables = Set<AnyCancellable>()
    let logFetching: LogFetching
    
    init(logFetching: LogFetching) {
        self.logFetching = logFetching
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func viewOnAppear() {
        logFetching.fetchLogs()
            .receive(on: RunLoop.main)
            .sink { (logs) in
                self.logs = logs
            }
            .store(in: &cancellables)
    }
    
}
