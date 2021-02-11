//
//  LogService.swift
//  MyRatedLogs
//
//  Created by Guye Raphael, I233 on 10.02.21.
//

import Foundation
import Combine

class LogService {
    
    func fetchLogs() -> AnyPublisher<[Log], Never> {
        Just(LogService.createMockList())
            .eraseToAnyPublisher()
    }
    
    func fetchLog(logId: Int) -> AnyPublisher<Log, Never> {
        Just(
            Log(id: 42, description: "this is a mock", date: Date(), ranking: 4)
        ).eraseToAnyPublisher()
    }
    
    private static func createMockList() -> [Log] {
        return [
            Log(id: 101, description: "desc 1", date: Date(), ranking: 5),
            Log(id: 102, description: "desc 2", date: Date(), ranking: 4),
            Log(id: 103, description: "desc 3", date: Date(), ranking: 3),
            Log(id: 104, description: "desc 4", date: Date(), ranking: 2),
            Log(id: 105, description: "desc 5", date: Date(), ranking: 1),
        ]
    }
    
}
