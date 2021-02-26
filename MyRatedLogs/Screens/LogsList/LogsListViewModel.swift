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
        let log = Log(id: "42", description: "Description of a Log", date: Date(), ranking: 3)
        do {
            try logFetching.postLog(log: log)
                .sink { (completion) in
                    switch completion {
                    case .finished:
                        print("postLog completion success")
                        break
                    case .failure(let error):
                        print("Error when trying to post log: \(error)")
                        break
                    }
                    self.fetchLogs()
                } receiveValue: { (data, response) in
                    print("receiveValue data: \(data)")
                    print("receiveValue response: \(response)")
                    guard let result = try? JSONDecoder().decode(Log.self, from: data) else {
                        print("error wheny trying to decode data in a Log")
                        return
                    }
                    print("result: \(result)")
                }
                .store(in: &cancellables)
        } catch let error {
            print("Exception catched when trying to postLog: \(error)")
        }
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
    
}
