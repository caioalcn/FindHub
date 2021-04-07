//
//  ServiceError.swift
//  FindHub
//
//  Created by Caio Alcântara on 04/04/21.
//

import Foundation

enum ServiceErrors: Error {
    case NotFound(error: ErrorMessage)
    case Unauthorized(error: ErrorMessage)
    case Forbidden(error: ErrorMessage)
    case serverResponseErrorWith(message: String)
    case noInternet
}

extension ServiceErrors {
    var message: String {
        switch self {
        case .Forbidden(let error):
            return error.message
        case .NotFound(_):
            return "We're sorry, couldn't find what you're looking :("
        case .Unauthorized(let error):
            return error.message
        case .serverResponseErrorWith(let message):
            return message
        case .noInternet:
            return "Please check your internet connnection!"
        }
    }
}
