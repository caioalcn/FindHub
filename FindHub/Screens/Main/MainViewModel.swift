//
//  MainViewModel.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    
    var didFetchList: ([Repository]?, Bool, Error?) -> () { get set}
    
    func fetchRepos(with user: String, page: Int)
}

final class MainViewModel: MainViewModelProtocol {
    
    var didFetchList: ([Repository]?, Bool, Error?) -> () = { _,_,_  in }
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
    var languageColor: String = ""
    var errorMessage: String = ""
    
    func fetchRepos(with user: String, page: Int) {
        APIGitHub().fetchUserRepos(user: user, page: page) { [weak self] (result, err) in
            guard let result = result else {
                self?.errorMessage = "We're sorry, couldn't find the user :("
                self?.didFetchList(nil, true, err)
                return
            }
                
            if self?.repositories.isEmpty ?? false {
                self?.errorMessage = "This user has no repositories!"
            }
            
            var lastPage = false
            if result.isEmpty {
                lastPage = true
            } else {
                self?.repositories += result
            }
            
            self?.didFetchList(result, lastPage, nil)
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
        languageColor = repo.language?.setLanguageColor() ?? ""
    }
}
