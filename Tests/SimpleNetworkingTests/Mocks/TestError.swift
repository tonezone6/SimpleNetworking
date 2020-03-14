//
//  File.swift
//  
//
//  Created by Alex on 14/03/2020.
//

import Foundation

enum TestError: LocalizedError {
    case mock
    
    var errorDescription: String? {
        return "mock error"
    }
}
