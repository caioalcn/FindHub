//
//  DetailRepoView.swift
//  FindHub
//
//  Created by Caio Alcântara on 04/04/21.
//

import UIKit

final class DetailRepoView: UIView {
    
    var viewModel: DetailRepoViewModel? {
        didSet {
            updateLayout()
        }
    }
    
    let repoNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.text = "Repo Name"
        label.font = UIFont(name: "Futura-Medium", size: 22)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = UIColor(named: AssetsColors.label.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let repoStargazersLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.text = "Repo Stargazers"
        label.font = UIFont(name: "Futura", size: 16)
        label.textAlignment = .center
        label.textColor = UIColor(named: AssetsColors.label.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let repoStarImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal))
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var stackViewStar: UIStackView = {
        var st = UIStackView(arrangedSubviews: [repoStarImage, repoStargazersLabel])
        
        st.axis = .vertical
        st.spacing = 0
        st.distribution = .fillEqually
        st.alignment = .center
        st.translatesAutoresizingMaskIntoConstraints = false
        
        return st
    }()
    
    lazy var stackViewMain: UIStackView = {
        var st = UIStackView(arrangedSubviews: [repoNameLabel, stackViewStar])
        
        st.axis = .horizontal
        st.spacing = 5
        st.distribution = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        
        return st
    }()
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        
        tb.register(DetailLanguageCell.self, forCellReuseIdentifier: DetailLanguageCell().kCellIdentifier)
        tb.register(DetailCommitCell.self, forCellReuseIdentifier: DetailCommitCell().kCellIdentifier)
        tb.separatorStyle = .none
        tb.backgroundColor = UIColor(named: AssetsColors.background.rawValue)
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 200
        tb.translatesAutoresizingMaskIntoConstraints = false
        
        return tb
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: AssetsColors.cell.rawValue)

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(stackViewMain)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            stackViewStar.widthAnchor.constraint(equalToConstant: 80),
            
            stackViewMain.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            stackViewMain.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            stackViewMain.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: stackViewMain.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        updateLayout()
    }
    
    private func updateLayout() {
        repoNameLabel.text = viewModel?.name
        repoStargazersLabel.text = "\(viewModel?.stargazersCount ?? 0)"
    }
}
