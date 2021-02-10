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
    var anyCancellable = Set<AnyCancellable>()
    let logService: LogService
    
    init(logService: LogService) {
        self.logService = logService
    }
    
    func viewOnAppear() {
        logService.fetchLogs()
            .receive(on: RunLoop.main)
            .sink { (logs) in
                self.logs = logs
            }
            .store(in: &anyCancellable)
    }
    
}
