//
//  CoordinatorType.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import UIKit

public protocol CoordinatorType: AnyObject {
    var childCoordinators: [CoordinatorType] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
