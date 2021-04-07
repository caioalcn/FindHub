//
//  IntroView.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation
import UIKit

final class IntroView: UIView {
        
    let topView: UIView = {
        let view = UIView()
        
        view.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        
        view.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let logoImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "git"))
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let versionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.text = "v" + DeviceHelper.version() + " " + "("+DeviceHelper.versionBuild()+")"
        label.font = UIFont(name: "Futura-Medium", size: 14)
        label.textAlignment = .right
        label.textColor = UIColor(named: AssetsColors.label.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var viewsHeightConstraint: NSLayoutConstraint!
    var topViewBottomConstraint: NSLayoutConstraint!
    
    init() {
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func setupLayout() {
        addSubview(topView)
        addSubview(bottomView)
        insertSubview(logoImage, at: 2)
        bottomView.addSubview(versionLabel)
                
        viewsHeightConstraint = bottomView.heightAnchor.constraint(equalTo: self.topView.heightAnchor, multiplier: 1)
        topViewBottomConstraint =  topView.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor)
        
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topViewBottomConstraint,
            
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor, multiplier: 9/16),
            logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            versionLabel.centerXAnchor.constraint(equalTo: self.bottomView.centerXAnchor, constant: 0),
            versionLabel.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.bottomView.safeAreaLayoutGuide.bottomAnchor, constant: -3),
            
            viewsHeightConstraint,
        ])
        
        perform(#selector(scaleImage), with: nil, afterDelay: 0.5)
    }
    
    private func openAnimation() {
        viewsHeightConstraint.isActive = false
        topViewBottomConstraint.isActive = false
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseOut) { [weak self] in
            self?.layoutIfNeeded()
            
            self?.versionLabel.alpha = 0
            self?.logoImage.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
    
    @objc private func scaleImage() {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseIn) { [weak self] in
            
            self?.logoImage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } completion: { (_) in
            UIView.animate(withDuration: 0.6) { [weak self] in
                self?.logoImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            } completion: { [weak self] _ in

                self?.openAnimation()
            }
        }
    }
}
