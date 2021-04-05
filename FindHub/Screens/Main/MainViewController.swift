//
//  MainViewController.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation
import UIKit

final class MainViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var mainView: MainView = {
        let view = MainView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        
        return view
    }()
    
    private let viewModel: MainViewModel
    private var searchUser = ""
    private var page = 1
    private var lastPage = false
    private var isLoadingData = false
    
    init(viewModel: MainViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        configureViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        setupNavigationSearch()
    }

    
    private func configureViewModel() {
        viewModel.didFetchList = { [weak self] result, lastPage, err in
            self?.isLoadingData = false
            self?.mainView.loadMoreSpinner.stopAnimating()
            self?.lastPage = lastPage
            self?.mainView.tableView.reloadData()
        }
    }
    
    private func setupNavigationSearch() {
        self.navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .white
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.searchTextField.autocapitalizationType = .none
        searchController.searchBar.placeholder = "Please enter the username"
    }
    
    private func cleanTable() {
        viewModel.repositories = []
        viewModel.errorMessage = ""
        searchUser = ""
        page = 1
        self.mainView.tableView.reloadData()
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        if !text.isEmpty {
            isLoadingData = true
            cleanTable()
            searchUser = text
            viewModel.fetchRepos(with: text, page: page)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cleanTable()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.repositories.count == 0 {
            tableView.setEmptyMessage(viewModel.errorMessage, isLoading: isLoadingData)
        } else {
            tableView.restore()
        }
        
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell().kCellIdentifier, for: indexPath) as? MainCell else { return UITableViewCell() }
        
        viewModel.cellForRepository(repo: viewModel.repositories[indexPath.row])
        cell.viewModel = viewModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.repositories.count - 1 {
            if !lastPage && !isLoadingData {
                page += 1
                isLoadingData = true
                mainView.loadMoreSpinner.startAnimating()
                viewModel.fetchRepos(with: searchUser, page: page)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        coordinator?.detailPush(selectedRepository: viewModel.repositories[indexPath.row])
    }
}
