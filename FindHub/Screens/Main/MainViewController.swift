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
        viewModel.didFetchList = { [weak self] result, err in
            self?.mainView.spinner.stopAnimating()
            self?.mainView.tableView.reloadData()
        }
    }
    
    private func setupNavigationSearch() {
        self.navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.searchTextField.autocapitalizationType = .none
        searchController.searchBar.placeholder = "Please enter the username"
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        if !text.isEmpty {
            mainView.spinner.startAnimating()
            viewModel.fetchRepos(with: text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.repositories = []
        self.mainView.tableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell().kCellIdentifier, for: indexPath) as? MainCell else { return UITableViewCell() }
        
        viewModel.cellForRepository(repo: viewModel.repositories[indexPath.row])
        cell.viewModel = viewModel
        
        return cell
    }
}
