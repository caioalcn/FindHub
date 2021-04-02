//
//  Router.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation

enum Router {
    case search(name: String)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var base: String {
        switch self {
        default:
            return "itunes.apple.com"
        }
    }
    
    var path: String {
        switch self {
        case .search(_):
            return "/search"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .search(let name):
            return [URLQueryItem(name: "term", value: name), URLQueryItem(name: "media", value: "podcast")]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search(_):
            return .get
        }
    }
}
