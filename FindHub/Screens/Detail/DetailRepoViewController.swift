//
//  DetailUserViewController.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import UIKit

final class DetailRepoController: UIViewController {
    
    private lazy var detailRepoView: DetailRepoView = {
        let view = DetailRepoView()
        
        view.tableView.dataSource = self
        view.tableView.delegate = self
        view.viewModel = viewModel

        return view
    }()
    
    let viewModel: DetailRepoViewModel
    
    private var isLoadingCommitsData = false
    private var isLoadingLanguagesData = false

    init(viewModel: DetailRepoViewModel, repository: Repository){
        viewModel.repository = repository
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        configureViewModel()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailRepoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Repository"
        viewModel.fetchRepoCommits(with: viewModel.owner, repo: viewModel.name, page: 1)
        viewModel.fetchRepoLanguages(with: viewModel.owner, repo: viewModel.name)
        isLoadingCommitsData = true
        isLoadingLanguagesData = true
    }
    
    private func configureViewModel() {
        self.viewModel.didFetchCommits = { [weak self] result, err in
            if err == ServiceErrors.noInternet {
                self?.presentAlertWithTitleOneButton(title: "Connection Problem", message: "Please check your internet connnection!", buttonTitle: "OK")
            }
            self?.isLoadingCommitsData = false
            self?.detailRepoView.tableView.reloadData()
        }
        
        self.viewModel.didFetchLanguages = { [weak self] result, err in
            self?.isLoadingLanguagesData = false
            self?.detailRepoView.tableView.reloadData()
        }
    }
}

extension DetailRepoController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Programming Languages"
        } else {
            return "Commits"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return isLoadingLanguagesData ? 1 : viewModel.languages.count
        } else {
            return isLoadingCommitsData ? 1 : viewModel.commits.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let languageCell = tableView.dequeueReusableCell(withIdentifier: DetailLanguageCell().kCellIdentifier, for: indexPath) as? DetailLanguageCell else { return UITableViewCell() }
            
            if !isLoadingLanguagesData {
                viewModel.cellForLanguage(lang: viewModel.languages[indexPath.row])
                languageCell.viewModel = viewModel
            }
            
            return languageCell
        } else {
            guard let commitCell = tableView.dequeueReusableCell(withIdentifier: DetailCommitCell().kCellIdentifier, for: indexPath) as? DetailCommitCell else { return UITableViewCell() }
            
            if !isLoadingCommitsData {
                viewModel.cellForCommit(repo: viewModel.commits[indexPath.row])
                commitCell.viewModel = viewModel
            }
            
            return commitCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44
        }
        return 250
    }
}
