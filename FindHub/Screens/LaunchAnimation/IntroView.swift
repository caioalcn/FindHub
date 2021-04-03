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
        
        view.backgroundColor = #colorLiteral(red: 0.03529411765, green: 0.1333333333, blue: 0.2823529412, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        
        view.backgroundColor = #colorLiteral(red: 0.03529411765, green: 0.1333333333, blue: 0.2823529412, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let logoImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "git"))
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
            
            viewsHeightConstraint,
        ])
        
        perform(#selector(scaleImage), with: nil, afterDelay: 0.5)
    }
    
    private func openAnimation() {
        viewsHeightConstraint.isActive = false
        topViewBottomConstraint.isActive = false
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.layoutIfNeeded()
            
            self.logoImage.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        } completion: { (_) in
            self.removeFromSuperview()
        }
    }
    
    @objc private func scaleImage() {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseIn) {
            
            self.logoImage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } completion: { (_) in
            UIView.animate(withDuration: 0.6) {
                self.logoImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            } completion: {(_) in

                self.openAnimation()
            }
        }
    }
}
