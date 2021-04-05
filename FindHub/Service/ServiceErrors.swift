//
//  ServiceError.swift
//  FindHub
//
//  Created by Caio Alcântara on 04/04/21.
//

import Foundation

enum ServiceErrors: Error, Equatable {
    case serverResponseErrorWith(message: String)
    case noInternet
}
