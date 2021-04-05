//
//  DetailRepoViewModel.swift
//  FindHub
//
//  Created by Caio Alcântara on 04/04/21.
//

import Foundation

protocol DetailRepoViewModelProtocol: AnyObject {
    var didFetchCommits: ([RepositoryCommit]?, Error?) -> () { get set}
    var didFetchLanguages: (Language?, Error?) -> () { get set}

    func fetchRepoCommits(with user: String, repo: String, page: Int)
}

final class DetailRepoViewModel: DetailRepoViewModelProtocol {
   
    var didFetchCommits: ([RepositoryCommit]?, Error?) -> () = { _, _ in }
    var didFetchLanguages: (Language?, Error?) -> () = { _, _ in }

    var repository: Repository?{
        didSet {
            updateValues()
        }
    }
    var commits: [RepositoryCommit] = []
    var languages: [String] = []
    var errorMessage: String = ""

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
            guard let result = result else {
                self?.errorMessage = "We're sorry, couldn't find the user :("
                self?.didFetchCommits(nil, err)
                return
            }
             
            self?.commits = result
            self?.didFetchCommits(result, err)
        }
    }
    
    func fetchRepoLanguages(with user: String, repo: String) {
        APIGitHub().fetchRepoLanguages(user: user, repo: repo) { [weak self] (result, err) in
            guard let result = result else {
                self?.didFetchLanguages(nil, err)
                return
            }
             
            self?.languages = result.name.sorted()
            self?.didFetchLanguages(result, err)
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
