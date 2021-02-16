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
        fetchLogs()
    }
    
    func fetchLogs() {
        logFetching.fetchLogs()
            .receive(on: RunLoop.main)
            .sink { (logs) in
                self.logs = logs
            }
            .store(in: &cancellables)
    }
    
    func addLog() {
        logFetching.addLog(
            log: Log(
                id: 42,
                description: "Description of a Log",
                date: Date(),
                ranking: 3)
        )
        .sink { (_) in
            self.fetchLogs()
        }
        .store(in: &cancellables)
    }
    
}
