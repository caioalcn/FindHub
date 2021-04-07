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
        
        return view
    }()
    
    private let viewModel: MainViewModel
    private var searchUser = ""
    private var page = 1
    private var lastPage = false
    private var isLoadingData = false
    
    var dataSource: UITableViewDiffableDataSource<Int, Repository>?
    
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
        dataSource = setupDataSource()
    }
    
    private func configureViewModel() {
        viewModel.didFetchList = { [weak self] result, lastPage in
            self?.lastPage = lastPage
            self?.fetchFinished()
        }
        
        viewModel.failFetch = { [weak self] err in
            self?.fetchFinished()
        }
    }
    
    private func setupNavigationSearch() {
        self.navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor(named: AssetsColors.label.rawValue)
        searchController.searchBar.searchTextField.textColor = UIColor(named: AssetsColors.label.rawValue)
        searchController.searchBar.searchTextField.autocapitalizationType = .none
        searchController.searchBar.placeholder = "Please enter the username"
    }
    
    private func resetTableView() {
        viewModel.repositories = []
        viewModel.responseMessage = ""
        searchUser = ""
        page = 1
        updateData(animation: false)
    }
    
    private func fetchFinished() {
        DispatchQueue.main.async {
            self.isLoadingData = false
            self.mainView.loadMoreSpinner.stopAnimating()
            self.updateData(animation: false)
        }
    }
    
    private func updateData(animation: Bool) {
        if viewModel.repositories.count == 0 {
            mainView.tableView.setEmptyMessage(viewModel.responseMessage, isLoading: isLoadingData)
        } else {
            mainView.tableView.restore()
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Repository>()
        snapshot.appendSections([0])
        snapshot.appendItems(self.viewModel.repositories)
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot, animatingDifferences: animation)
        }
    }
    
    private func setupDataSource() -> UITableViewDiffableDataSource<Int, Repository> {
        return UITableViewDiffableDataSource(tableView: mainView.tableView, cellProvider: { (table, index, model) -> UITableViewCell? in
            
            let cell = table.dequeueReusableCell(withIdentifier: MainCell().kCellIdentifier, for: index) as? MainCell
            
            self.viewModel.cellForRepository(repo: model)
            cell?.viewModel = self.viewModel
            
            return cell
        })
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        if !text.isEmpty {
            isLoadingData = true
            resetTableView()
            searchUser = text
            viewModel.fetchRepos(with: text, page: page)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetTableView()
    }
}

extension MainViewController: UITableViewDelegate {
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
        
        guard let repository = dataSource?.itemIdentifier(for: indexPath) else { return }
        coordinator?.detailPush(selectedRepository: repository)
    }
}
