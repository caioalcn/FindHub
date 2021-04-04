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
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.1058823529, blue: 0.1333333333, alpha: 1)
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            // Fallback on earlier versions
            self.navigationBar.barTintColor = #colorLiteral(red: 0.0862745098, green: 0.1058823529, blue: 0.1333333333, alpha: 1)
            self.navigationBar.tintColor = .white
            self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont(name: "Futura", size: 30)!]
            self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont(name: "Futura", size: 21)!]
        }
    }
}
