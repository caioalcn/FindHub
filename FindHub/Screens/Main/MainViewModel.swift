//
//  MainViewModel.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    
    var didFetchList: ([Repository]?, Error?) -> () { get set}
    
    func fetchRepos(with user: String)
}

final class MainViewModel: MainViewModelProtocol {
    
    var didFetchList: ([Repository]?, Error?) -> () = { _,_ in }
    var repositories: [Repository] = []
    
    var name: String = ""
    var fullName: String = ""
    var htmlUrl: String = ""
    var description: String?
    var createdAt: String = ""
    var updatedAt: String = ""
    var pushedAt: String = ""
    var stargazersCount: Int = 0
    var language: String?
    
    func fetchRepos(with user: String) {
        APIGitHub().fetchUserRepos(user: user) { [weak self] (result, err) in
            guard let result = result else {
                self?.didFetchList(nil, err)
                return
            }
            
            self?.repositories = result
            self?.didFetchList(result, nil)
        }
    }
    
    func cellForRepository(repo: Repository) {
        name = repo.name
        fullName = repo.fullName
        htmlUrl = repo.htmlUrl
        description = repo.description
        createdAt = repo.createdAt
        updatedAt = repo.updatedAt
        pushedAt = repo.pushedAt
        stargazersCount = repo.stargazersCount
        language = repo.language
    }
}
