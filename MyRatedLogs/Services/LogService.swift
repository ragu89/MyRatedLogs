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
    
    private static func createMockList() -> [Log] {
        return [
            Log(description: "desc 1", date: Date(), ranking: 5),
            Log(description: "desc 2", date: Date(), ranking: 4),
            Log(description: "desc 3", date: Date(), ranking: 3),
            Log(description: "desc 4", date: Date(), ranking: 2),
            Log(description: "desc 5", date: Date(), ranking: 1),
        ]
    }
    
}
