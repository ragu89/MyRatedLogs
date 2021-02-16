//
//  LogDetailViewModel.swift
//  MyRatedLogs
//
//  Created by Guye Raphael, I233 on 11.02.21.
//

import Foundation
import Combine

class LogDetailViewModel : ObservableObject {
    
    let logId: Int
    let logFetching: LogFetching
    
    @Published var fetchedLog: Log?
    var cancellables = Set<AnyCancellable>()
    
    init(logId: Int, logFetching: LogFetching) {
        self.logId = logId
        self.logFetching = logFetching
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func viewOnAppear() {
        logFetching.fetchLog(logId: logId)
            .receive(on: RunLoop.main)
            .sink {
                self.fetchedLog = $0
            }
            .store(in: &cancellables)
    }
    
}
