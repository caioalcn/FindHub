//
//  UIViewController+Extension.swift
//  FindHub
//
//  Created by Caio Alcântara on 02/04/21.
//

import UIKit

extension UIView {
    func hideKeyboardWhenTappedScreen() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        self.endEditing(true)
    }
}
