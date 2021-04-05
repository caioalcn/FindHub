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
    
    func fetchRepoCommits(user: String, repo: String, page: Int, completion: @escaping ([RepositoryCommit]?, Error?) -> ()) {
        ServiceLayer.request(router: .searchRepoCommits(user: user, repo: repo, page: page)) { (response: Result<[RepositoryCommit]?, Error>) in
            switch response {
            case .success(let result):
                completion(result, nil)
            case .failure(let err):
                completion(nil, err)
            }
        }
    }
    
    func fetchRepoLanguages(user: String, repo: String, completion: @escaping (Language?, Error?) -> ()) {
        ServiceLayer.request(router: .searchRepoLanguages(user: user, repo: repo)) { (response: Result<Language?, Error>) in
            switch response {
            case .success(let result):
                completion(result, nil)
            case .failure(let err):
                completion(nil, err)
            }
        }
    }
}
