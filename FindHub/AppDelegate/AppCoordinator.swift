//
//  AppCoordinator.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation
import UIKit

final class AppCoordinator: CoordinatorType {
        
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorType] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let viewModel = MainViewModel()
        let mainController = MainViewController(viewModel: viewModel)
        mainController.coordinator = self
        navigationController.setViewControllers([mainController], animated: true)
    }
    
    public func detailPush() {
        let detailController = DetailUserController()
        detailController.coordinator = self
        navigationController.pushViewController(detailController, animated: true)
    }
    
}
