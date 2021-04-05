//
//  DetailCommitCell.swift
//  FindHub
//
//  Created by Caio Alcântara on 04/04/21.
//

import UIKit

final class DetailCommitCell: UITableViewCell {
    let kCellIdentifier = "DetailCommitCellIdentifier"
    
    var viewModel: DetailRepoViewModel? {
        didSet {
            updateLayout()
        }
    }
    
    let cellView: UIView = {
        let view = UIView(frame: .zero)
        
        view.backgroundColor = UIColor(named: AssetsColors.cell.rawValue)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let loadMoreSpinner: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = UIColor(named: AssetsColors.label.rawValue)
        activity.startAnimating()
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        return activity
    }()
    
    
    let authorNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.text = "Author Name"
        label.font = UIFont(name: "Futura-Medium", size: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(named: AssetsColors.label.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let commitMessageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.text = "Commit Message"
        label.font = UIFont(name: "Futura", size: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.text = "Commit Date"
        label.font = UIFont(name: "Futura", size: 12)
        label.textAlignment = .right
        label.textColor = UIColor(named: AssetsColors.label.rawValue)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    lazy var stackViewMain: UIStackView = {
        var st = UIStackView(arrangedSubviews: [authorNameLabel, commitMessageLabel, dateLabel])
        
        st.axis = .vertical
        st.spacing = 5
        st.distribution = .equalSpacing
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        
        return st
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        authorNameLabel.text = ""
        commitMessageLabel.text = ""
        dateLabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(cellView)
        cellView.addSubview(stackViewMain)
        cellView.addSubview(loadMoreSpinner)

        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
    
            loadMoreSpinner.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            loadMoreSpinner.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
        
            stackViewMain.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            stackViewMain.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            stackViewMain.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            stackViewMain.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
        ])
    }
    
    private func updateLayout() {
        authorNameLabel.text = viewModel?.authorName
        commitMessageLabel.text = viewModel?.message
        dateLabel.text = viewModel?.authorDate
        
        authorNameLabel.sizeToFit()
        commitMessageLabel.sizeToFit()
        dateLabel.sizeToFit()
        self.layoutIfNeeded()
        loadMoreSpinner.stopAnimating()
    }
}
