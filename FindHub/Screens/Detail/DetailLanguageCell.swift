//
//  DetailLanguageCell.swift
//  FindHub
//
//  Created by Caio Alcântara on 04/04/21.
//

import UIKit

final class DetailLanguageCell: UITableViewCell {
    let kCellIdentifier = "DetailLanguageCellIdentifier"
    
    var viewModel: DetailRepoViewModel? {
        didSet {
            updateLayout()
        }
    }
    
    let loadMoreSpinner: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = .white
        activity.startAnimating()
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        return activity
    }()
    
    let cellView: UIView = {
        let view = UIView(frame: .zero)
        
        view.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.1058823529, blue: 0.1333333333, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let colorLanguageView: UIView = {
        let view = UIView(frame: .zero)
        
        view.layer.cornerRadius = 7.5
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let repoLanguageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.text = "Repo Language"
        label.font = UIFont(name: "Futura", size: 14)
        label.textAlignment = .left
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
   
    lazy var stackViewLanguage: UIStackView = {
        var st = UIStackView(arrangedSubviews: [colorLanguageView, repoLanguageLabel])
        
        st.axis = .horizontal
        st.spacing = 10
        st.distribution = .fill
        st.alignment = .center
        st.translatesAutoresizingMaskIntoConstraints = false
        
        return st
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        repoLanguageLabel.text = ""
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
        cellView.addSubview(stackViewLanguage)
        cellView.addSubview(loadMoreSpinner)

        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
    
            loadMoreSpinner.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            loadMoreSpinner.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
                
            stackViewLanguage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 0),
            stackViewLanguage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 15),
            stackViewLanguage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: 0),
            stackViewLanguage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 0),
            
            colorLanguageView.heightAnchor.constraint(equalToConstant: 15),
            colorLanguageView.widthAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func updateLayout() {
        repoLanguageLabel.text = viewModel?.languageName
        colorLanguageView.backgroundColor = viewModel?.languageColor.isEmpty ?? false ? UIColor.clear : UIColor.init(hex: viewModel?.languageColor ?? "")
        loadMoreSpinner.stopAnimating()
    }
}
