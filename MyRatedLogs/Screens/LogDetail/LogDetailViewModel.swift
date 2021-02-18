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
    @Published var loadingError = false
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
        loadingError = false
        logFetching.fetchLog(logId: logId)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error when trying to fetch log \(self.logId): \(error)")
                    self.loadingError = true
                }
            }, receiveValue: { (fetchedLog) in
                self.fetchedLog = fetchedLog
            })
            .store(in: &cancellables)
    }
    
}
