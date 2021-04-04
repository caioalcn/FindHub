//
//  MainCell.swift
//  FindHub
//
//  Created by Caio Alcântara on 02/04/21.
//

import UIKit

final class MainCell: UITableViewCell {
    
    let kCellIdentifier = "MainCellIdentifier"
    
    var viewModel: MainViewModel? {
        didSet {
            updateLayout()
        }
    }
    
    let cellView: UIView = {
        let view = UIView(frame: .zero)
        
        view.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.1058823529, blue: 0.1333333333, alpha: 1)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let repoNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.text = "Repo Name"
        label.font = UIFont(name: "Futura-Medium", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let colorLanguageView: UIView = {
        let view = UIView(frame: .zero)
        
        view.layer.cornerRadius = 7.5
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let repoLanguageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.text = "Repo Language"
        label.font = UIFont(name: "Futura", size: 16)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let repoStargazersLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.text = "Repo Stargazers"
        label.font = UIFont(name: "Futura", size: 12)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let repoStarImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal))
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    lazy var stackViewLabel: UIStackView = {
        var st = UIStackView(arrangedSubviews: [repoNameLabel, stackViewLanguage])
        
        st.axis = .vertical
        st.spacing = 5
        st.distribution = .fill
        st.alignment = .leading
        st.translatesAutoresizingMaskIntoConstraints = false
        
        return st
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
        var st = UIStackView(arrangedSubviews: [stackViewLabel, stackViewStar])
        
        st.axis = .horizontal
        st.spacing = 5
        st.distribution = .fillProportionally
        st.translatesAutoresizingMaskIntoConstraints = false
        
        return st
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        repoNameLabel.text = ""
        repoLanguageLabel.text = ""
        repoStargazersLabel.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(cellView)
        cellView.addSubview(stackViewMain)
        
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
    
            stackViewStar.widthAnchor.constraint(equalToConstant: 80),
            stackViewMain.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            stackViewMain.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 15),
            stackViewMain.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -5),
            
            colorLanguageView.heightAnchor.constraint(equalToConstant: 15),
            colorLanguageView.widthAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func updateLayout() {
        repoNameLabel.text = viewModel?.name
        colorLanguageView.backgroundColor = viewModel?.languageColor.isEmpty ?? false ? UIColor.clear : UIColor.init(hex: viewModel?.languageColor ?? "#ffffff")
        repoLanguageLabel.text = viewModel?.language ?? ""
        repoStargazersLabel.text = "\(viewModel?.stargazersCount ?? 0)"
    }
}
