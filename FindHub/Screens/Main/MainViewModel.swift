//
//  MainViewModel.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    
    var didFetchList: ([Repository]?, Bool) -> () { get set}
    var failFetch: (String) -> () { get set}
    
    func fetchRepos(with user: String, page: Int)
}

final class MainViewModel: MainViewModelProtocol {
    
    var didFetchList: ([Repository]?, Bool) -> () = { _,_  in }
    var failFetch: (String) -> () = { _ in }
    
    var repositories: [Repository] = []
    
    var name: String = ""
    var stargazersCount: Int = 0
    var language: String?
    var languageColor: String = ""
    var responseMessage: String = ""
    
    func fetchRepos(with user: String, page: Int) {
        APIGitHub().fetchUserRepos(user: user, page: page) { [weak self] (result, err) in
            if let err = err {
                self?.responseMessage = err.message
                self?.failFetch(err.message)
            }

            guard let result = result else { return }
                
            if self?.repositories.isEmpty ?? false {
                self?.responseMessage = "This user has no repositories!"
            }
            
            var lastPage = false
            if result.isEmpty {
                lastPage = true
            } else {
                self?.repositories += result
            }
            
            self?.didFetchList(result, lastPage)
        }
    }
    
    func cellForRepository(repo: Repository) {
        name = repo.name
        stargazersCount = repo.stargazersCount
        language = repo.language
        languageColor = repo.language?.setLanguageColor() ?? ""
    }
}
