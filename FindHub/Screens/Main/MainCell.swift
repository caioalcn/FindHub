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
            textLabel?.text = viewModel?.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
