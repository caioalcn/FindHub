//
//  Router.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation

enum Router {
    case searchUserRepos(user: String, page: Int)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var base: String {
        switch self {
        default:
            return "api.github.com"
        }
    }
    
    var path: String {
        switch self {
        case .searchUserRepos(let user, _):
            return "/users/\(user)/repos"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .searchUserRepos(_, let page):
            return [URLQueryItem(name: "per_page", value: "20"), URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "sort", value: "updated")]
        }
    }

    var method: HTTPMethod {
        switch self {
        case .searchUserRepos(_,_):
            return .get
        }
    }
}
