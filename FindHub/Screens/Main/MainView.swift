//
//  MainView.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import UIKit

protocol MainViewProtocol: class {
    func createList()
}

final class MainView: UIView {
    
    weak var delegate: MainViewProtocol?
    
    private lazy var introView: IntroView = {
        let view = IntroView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var createButton: UIButton = {
        
        let button = UIButton(type: .system)
        
        button.setTitle("New List", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9278818965, green: 0.4297862649, blue: 0, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Futura-Medium", size: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createList), for: .touchUpInside)

        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        addSubview(createButton)
        
        let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })!
        window.addSubview(introView)
        
        NSLayoutConstraint.activate([
            introView.topAnchor.constraint(equalTo: window.topAnchor),
            introView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            introView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            introView.bottomAnchor.constraint(equalTo: window.bottomAnchor),

            createButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            createButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            createButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    @objc private func createList(){
        delegate?.createList()
    }
}
