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
    let logService: LogService
    
    @Published var fetchedLog: Log?
    var cancellables = Set<AnyCancellable>()
    
    init(logId: Int, logService: LogService) {
        self.logId = logId
        self.logService = logService
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func viewOnAppear() {
        logService.fetchLog(logId: logId)
            .receive(on: RunLoop.main)
            .sink {
                self.fetchedLog = $0
            }
            .store(in: &cancellables)
    }
    
}
