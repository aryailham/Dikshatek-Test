//
//  ErrorMessage.swift
//  Dikshatek Test
//
//  Created by Arya Ilham on 23/02/24.
//

import Foundation

struct ErrorMessage: Error, Codable {
    let status: String
    let code: String
    let message: String
    var localizedDescription: String {
        return message
    }
}

extension Error {
    func getErrorMessageObject() -> ErrorMessage {
        return self as! ErrorMessage
    }
}
