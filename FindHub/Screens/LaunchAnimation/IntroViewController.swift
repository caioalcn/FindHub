//
//  IntroViewController.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation
import UIKit

final class IntroViewController: UIViewController {
    
    var appCoordinator: AppCoordinator?
    
    private lazy var introView: IntroView = {
        let view = IntroView()
        view.delegate = self
        return view
    }()
    
    
    
    override func loadView() {
        self.view = introView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension IntroViewController: IntroViewProtocol {
    func setMainRootController() {
        let navController = UINavigationController()
        let coordinator = AppCoordinator(navigationController: navController)
        coordinator.start()

        self.appCoordinator = coordinator
        
        UIApplication.shared.windows.first?.rootViewController = coordinator.navigationController
    }
}
