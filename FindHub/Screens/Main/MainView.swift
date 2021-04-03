//
//  MainView.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import UIKit


final class MainView: UIView {
        
    private lazy var introView: IntroView = {
        let view = IntroView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    let spinner: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = #colorLiteral(red: 0.0862745098, green: 0.1058823529, blue: 0.1333333333, alpha: 1)
        
        return activity
    }()
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        
        tb.register(MainCell.self, forCellReuseIdentifier: MainCell().kCellIdentifier)
        tb.tableFooterView = UIView()
        tb.backgroundView = spinner
        tb.separatorStyle = .none
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 100
        tb.translatesAutoresizingMaskIntoConstraints = false
        
        return tb
    }()

    /*
    private lazy var searchTextField: UITextField = {
        
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Please insert the username",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.font = UIFont(name: "Futura", size: 15)
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .white
        textField.returnKeyType = .search
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    */
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.06666666667, blue: 0.09019607843, alpha: 1)
        self.hideKeyboardWhenTappedScreen()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        addSubview(tableView)
        
        let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })!
        window.addSubview(introView)
        
        NSLayoutConstraint.activate([
            introView.topAnchor.constraint(equalTo: window.topAnchor),
            introView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            introView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            introView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
