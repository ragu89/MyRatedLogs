//
//  Log.swift
//  MyRatedLogs
//
//  Created by Guye Raphael, I233 on 10.02.21.
//

import Foundation

struct Log: Codable {
    
    let id: String
    let description: String
    let date: Date
    let ranking: Int
    
    var dateFormatted : String {
        get {
            return "2001-09-11"
        }
    }
    
}
