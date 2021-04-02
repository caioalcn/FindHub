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
    
    private lazy var mainView: MainView = {
        let view = MainView()
        view.delegate = self
        return view
    }()
    
    private let viewModel: MainViewModel

    init(viewModel: MainViewModel) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .orange
        self.viewModel.fetchList()
    }
}

extension MainViewController: MainViewProtocol {
    func createList() {
        coordinator?.detailPush()
    }
}
