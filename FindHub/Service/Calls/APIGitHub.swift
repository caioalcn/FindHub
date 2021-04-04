//
//  APIGitHub.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation

protocol ServiceProtocol {
    func fetchUserRepos(user: String, page: Int, completion: @escaping ([Repository]?, Error?) -> Void)
}

struct APIGitHub: ServiceProtocol {

    func fetchUserRepos(user: String, page: Int, completion: @escaping ([Repository]?, Error?) -> ()) {
        ServiceLayer.request(router: .searchUserRepos(user: user, page: page)) { (response: Result<[Repository]?, Error>) in
            switch response {
            case .success(let result):
                completion(result, nil)
            case .failure(let err):
                completion(nil, err)
            }
        }
    }
}
