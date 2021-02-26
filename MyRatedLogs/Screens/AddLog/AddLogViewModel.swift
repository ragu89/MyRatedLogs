//
//  AddLogViewModel.swift
//  MyRatedLogs
//
//  Created by Guye Raphael, I233 on 26.02.21.
//

import Foundation
import SwiftUI

class AddLogViewModel : ObservableObject {
    
    @Binding var isPresented: Bool
    
    @Published var description = ""
    @Published var date = Date()
    @Published var ranking = 0
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    func saveLog() {
        isPresented = false
    }
    
    func cancel() {
        isPresented = false
    }
    
}
