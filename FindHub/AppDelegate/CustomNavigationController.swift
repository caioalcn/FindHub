//
//  CustomNavigationController.swift
//  FindHub
//
//  Created by Caio Alcântara on 02/04/21.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.prefersLargeTitles = true
        self.extendedLayoutIncludesOpaqueBars = true
        
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: AssetsColors.label.rawValue) ?? UIColor.systemBackground]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: AssetsColors.label.rawValue) ?? UIColor.systemBackground]
            navBarAppearance.backgroundColor = UIColor(named: AssetsColors.navigation.rawValue)
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            // Fallback on earlier versions
            self.navigationBar.barTintColor = UIColor(named: AssetsColors.navigation.rawValue)
            self.navigationBar.tintColor = UIColor(named: AssetsColors.navigation.rawValue)
            self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: AssetsColors.label.rawValue) ?? UIColor.systemBackground, NSAttributedString.Key.font: UIFont(name: "Futura", size: 30)!]
            self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: AssetsColors.background.rawValue) ?? UIColor.systemBackground, NSAttributedString.Key.font: UIFont(name: "Futura", size: 21)!]
        }
    }
}
