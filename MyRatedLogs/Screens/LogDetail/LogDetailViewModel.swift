//
//  LogDetailViewModel.swift
//  MyRatedLogs
//
//  Created by Guye Raphael, I233 on 11.02.21.
//

import Foundation
import Combine

class LogDetailViewModel : ObservableObject {
    
    let logId: String
    let logFetching: LogFetching
    
    @Published var fetchedLog: Log?
    var cancellables = Set<AnyCancellable>()
    
    init(logId: String, logFetching: LogFetching) {
        self.logId = logId
        self.logFetching = logFetching
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func viewOnAppear() {
        fetchLogs()
    }
    
    private func fetchLogs() {
        fetchedLog = nil
        logFetching.fetchLog(logId: logId)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink {
                self.fetchedLog = $0
            }
            .store(in: &cancellables)
    }
    
}
