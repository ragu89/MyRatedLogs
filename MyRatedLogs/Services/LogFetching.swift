//
//  MockLogFetching.swift
//  MyRatedLogs
//
//  Created by Guye Raphael, I233 on 10.02.21.
//

import Foundation
import Combine

protocol LogFetching {
    func fetchLogs() -> AnyPublisher<[Log], Never>
    func fetchLog(logId: Int) -> AnyPublisher<Log?, Never>
    func addLog(log: Log) -> AnyPublisher<Bool, Never>
}

class LogFetcher : LogFetching {
    
    private var logs = [Log]()
    
    func fetchLogs() -> AnyPublisher<[Log], Never> {
        return Just(logs)
            .eraseToAnyPublisher()
    }
    
    func fetchLog(logId: Int) -> AnyPublisher<Log?, Never> {
        return logs
            .first(where: {
                $0.id == logId
            })
            .map {
                Just($0)
                    .subscribe(on: OperationQueue())
                    .map {
                        sleep(2)
                        return $0
                    }
                    .eraseToAnyPublisher()
            } ?? Just(nil).eraseToAnyPublisher()
    }
    
    func addLog(log: Log) -> AnyPublisher<Bool, Never> {
        return Just(true)
            .subscribe(on: OperationQueue())
            .map{
                sleep(2)
                self.logs.append(log)
                return $0
            }
            .eraseToAnyPublisher()
    }
    
}

class MockLogFetching : LogFetching {
    
    func fetchLogs() -> AnyPublisher<[Log], Never> {
        Just(MockLogFetching.createMockList())
            .eraseToAnyPublisher()
    }
    
    func fetchLog(logId: Int) -> AnyPublisher<Log?, Never> {
        Just(
            Log(id: 42, description: "this is a mock", date: Date(), ranking: 4)
        ).eraseToAnyPublisher()
    }
    
    func addLog(log: Log) -> AnyPublisher<Bool, Never> {
        return Just(true).eraseToAnyPublisher()
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
