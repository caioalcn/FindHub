//
//  APIGitHub.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation

protocol ServiceProtocol {
    func fetchUserRepos(user: String, page: Int, completion: @escaping ([Repository]?, ServiceErrors?) -> Void)
    func fetchRepoCommits(user: String, repo: String, page: Int, completion: @escaping ([RepositoryCommit]?, ServiceErrors?) -> ())
    func fetchRepoLanguages(user: String, repo: String, completion: @escaping (Language?, ServiceErrors?) -> ())
}

struct APIGitHub: ServiceProtocol {

    func fetchUserRepos(user: String, page: Int, completion: @escaping ([Repository]?, ServiceErrors?) -> ()) {
        ServiceLayer.request(router: .searchUserRepos(user: user, page: page)) { (response: Result<[Repository]?, ServiceErrors>) in
            switch response {
            case .success(let result):
                completion(result, nil)
            case .failure(let err):
                completion(nil, err)
            }
        }
    }
    
    func fetchRepoCommits(user: String, repo: String, page: Int, completion: @escaping ([RepositoryCommit]?, ServiceErrors?) -> ()) {
        ServiceLayer.request(router: .searchRepoCommits(user: user, repo: repo, page: page)) { (response: Result<[RepositoryCommit]?, ServiceErrors>) in
            switch response {
            case .success(let result):
                completion(result, nil)
            case .failure(let err):
                completion(nil, err)
            }
        }
    }
    
    func fetchRepoLanguages(user: String, repo: String, completion: @escaping (Language?, ServiceErrors?) -> ()) {
        ServiceLayer.request(router: .searchRepoLanguages(user: user, repo: repo)) { (response: Result<Language?, ServiceErrors>) in
            switch response {
            case .success(let result):
                completion(result, nil)
            case .failure(let err):
                completion(nil, err)
            }
        }
    }
}
