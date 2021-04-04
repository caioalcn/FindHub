//
//  UITableView+Extension.swift
//  FindHub
//
//  Created by Caio Alcântara on 04/04/21.
//

import UIKit

extension UITableView {
    func setEmptyMessage(_ message: String, isLoading: Bool) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Futura", size: 20)
        messageLabel.sizeToFit()
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        spinner.startAnimating()
        
        if isLoading {
            self.backgroundView = spinner
        } else {
            self.backgroundView = messageLabel
        }
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
