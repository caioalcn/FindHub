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

    let loadMoreSpinner: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = .white
        
        return activity
    }()
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        
        tb.register(MainCell.self, forCellReuseIdentifier: MainCell().kCellIdentifier)
        tb.tableFooterView = UIView()
        tb.tableFooterView = loadMoreSpinner
        tb.separatorStyle = .none
        tb.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.06666666667, blue: 0.09019607843, alpha: 1)
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 200
        tb.translatesAutoresizingMaskIntoConstraints = false
        
        return tb
    }()
    
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
