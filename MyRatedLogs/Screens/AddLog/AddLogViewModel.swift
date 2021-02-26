//
//  AddLogViewModel.swift
//  MyRatedLogs
//
//  Created by Guye Raphael, I233 on 26.02.21.
//

import Foundation
import SwiftUI
import Combine

class AddLogViewModel : ObservableObject {
    
    @Binding var isPresented: Bool
    
    @Published var description = ""
    @Published var ranking = 0
    @Published var date = Date()
    
    @Published var isLoading = false
    @Published var isAddLogViewDisplayed = false
    
    private let logAddedCompletion: () -> Void
    private let logFetching: LogFetching
    private var cancellables = Set<AnyCancellable>()
    
    init(
        logFetching: LogFetching,
        logAddedCompletion: @escaping () -> Void,
        isPresented: Binding<Bool>
    ) {
        self.logFetching = logFetching
        self.logAddedCompletion = logAddedCompletion
        self._isPresented = isPresented
    }
    
    func cancel() {
        isPresented = false
    }
    
    func saveLog() {
        isLoading = true
        let log = Log(id: "42", description: description, date: date, ranking: ranking)
        do {
            try logFetching.postLog(log: log)
                .receive(on: RunLoop.main)
                .sink { (completion) in
                    switch completion {
                    case .finished:
                        print("postLog completion success")
                        break
                    case .failure(let error):
                        print("Error when trying to post log: \(error)")
                        break
                    }
                    
                    self.isLoading = false
                    self.isPresented = false
                    self.logAddedCompletion()
                    
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
    
}
