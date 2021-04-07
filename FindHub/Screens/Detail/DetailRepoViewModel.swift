//
//  DetailRepoViewModel.swift
//  FindHub
//
//  Created by Caio Alcântara on 04/04/21.
//

import Foundation

protocol DetailRepoViewModelProtocol: AnyObject {
    var didFetchCommits: ([RepositoryCommit]?) -> () { get set}
    var didFetchLanguages: (Language?) -> () { get set}
    var failFetchCommits: (String) -> () { get set}
    var failFetchLanguages: (String) -> () { get set}
    
    func fetchRepoCommits(with user: String, repo: String, page: Int)
}

final class DetailRepoViewModel: DetailRepoViewModelProtocol {
   
    var didFetchCommits: ([RepositoryCommit]?) -> () = { _ in }
    var didFetchLanguages: (Language?) -> () = { _ in }
    var failFetchCommits: (String) -> () = { _ in }
    var failFetchLanguages: (String) -> () = { _ in }

    var repository: Repository?{
        didSet {
            updateValues()
        }
    }
    var commits: [RepositoryCommit] = []
    var languages: [String] = []
    var responseMessage: String = ""

    var name: String = ""
    var stargazersCount: Int = 0
    
    var authorName: String = ""
    var authorEmail: String = ""
    var authorDate: String = ""
    var message: String = ""
    var owner: String = ""
    
    var languageName: String = ""
    var languageColor: String = ""
    
    func fetchRepoCommits(with user: String, repo: String, page: Int) {
        APIGitHub().fetchRepoCommits(user: user, repo: repo, page: page) { [weak self] (result, err) in
            if let err = err {
                self?.responseMessage = err.message
                self?.failFetchCommits(err.message)
            }
            
            guard let result = result else { return }
             
            self?.commits = result
            self?.didFetchCommits(result)
        }
    }
    
    func fetchRepoLanguages(with user: String, repo: String) {
        APIGitHub().fetchRepoLanguages(user: user, repo: repo) { [weak self] (result, err) in
            if let err = err {
                self?.responseMessage = err.message
                self?.failFetchLanguages(err.message)
            }
            
            guard let result = result else { return }
             
            self?.languages = result.name.sorted()
            if result.name.contains("documentation_url") {
                self?.languages = []
            }
            self?.didFetchLanguages(result)
        }
    }
    
    func cellForCommit(repo: RepositoryCommit) {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM d, h:mm a"
        
        authorName = repo.commit.author.name
        authorEmail = repo.commit.author.email
        authorDate = formatter.string(from: repo.commit.author.date.toDate() ?? Date())
        message = repo.commit.message
    }
    
    func cellForLanguage(lang: String) {
        languageName = lang
        languageColor = lang.setLanguageColor() 
    }
    
    func updateValues() {
        guard let repository = repository else { return }
        
        name = repository.name
        stargazersCount = repository.stargazersCount
        owner = repository.owner.login
    }
}
