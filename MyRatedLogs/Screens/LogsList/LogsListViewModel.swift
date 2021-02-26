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
    @Published var isAddLogViewDisplayed = false
    
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
    
    func delete(at offsets: IndexSet) {
        isLoading = true
        
        guard let logId = offsets.map({ self.logs[$0].id }).first else {
            isLoading = false
            return
        }
        
        logFetching.deleteLog(logId: logId)
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("deleteLog \(logId) completion success")
                    break
                case .failure(let error):
                    print("Error when trying to delete log \(logId): \(error)")
                    break
                }
                self.fetchLogs()
            } receiveValue: { (data, response) in
            }
            .store(in: &cancellables)
    }
    
    func onLogAdded() {
        self.fetchLogs()
    }
    
}
