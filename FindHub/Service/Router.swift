//
//  Router.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation

enum Router {
    case searchUserRepos(user: String, page: Int)
    case searchRepoCommits(user: String, repo: String, page: Int)
    case searchRepoLanguages(user: String, repo: String)
    
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
        case .searchRepoCommits(let user, let repo, _):
            return "/repos/\(user)/\(repo)/commits"
        case .searchRepoLanguages(let user, let repo):
            return "/repos/\(user)/\(repo)/languages"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .searchUserRepos(_, let page):
            return [URLQueryItem(name: "per_page", value: "20"), URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "sort", value: "updated")]
        case .searchRepoCommits(_, _, let page):
            return [URLQueryItem(name: "per_page", value: "5"), URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "sort", value: "updated")]
        default:
            return []
        }
    }

    var method: HTTPMethod {
        switch self {
        case .searchUserRepos(_,_), .searchRepoCommits(_, _, _), .searchRepoLanguages(_, _):
            return .get
        }
    }
}
