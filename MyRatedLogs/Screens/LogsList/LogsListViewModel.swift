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
    @Published var isLoading = false
    var cancellables = Set<AnyCancellable>()
    let logFetching: LogFetching
    
    init(logFetching: LogFetching) {
        self.logFetching = logFetching
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func viewOnAppear() {
        fetchLogs()
    }
    
    func fetchLogs() {
        isLoading = true
        logFetching.fetchLogs()
            .receive(on: RunLoop.main)
            .sink { (logs) in
                self.logs = logs
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func addLog() {
        isLoading = true
        logFetching.addLog(
            log: Log(
                id: "2",
                description: "Description of a Log",
                date: Date(),
                ranking: 3)
        )
        .receive(on: RunLoop.main)
        .sink { (_) in
            self.fetchLogs()
            self.isLoading = false
        }
        .store(in: &cancellables)
    }
    
}
