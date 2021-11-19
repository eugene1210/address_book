//
//  TabBarView.swift
//  Address Book
//
//  Created by Admin on 17.11.2021.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class TabBarView: UIView {
    
    lazy var markButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bookmark_Icon"), for: .normal)
        button.setImage(UIImage(named: "bookmark_Icon_Selected"), for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var mapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "location_Icon_Tab"), for: .normal)
        button.setImage(UIImage(named: "location_Icon_Selected"), for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var profileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Account_Icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(self.markButton)
        stack.addArrangedSubview(self.mapButton)
        stack.addArrangedSubview(self.profileButton)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.backgroundColor = .white
        self.layer.cornerRadius = Constants.tabBarCornerRadius
        self.layer.shadowOpacity = Constants.tabBarShadowOpacity
        self.layer.shadowRadius = Constants.tabBarShadowRadius
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
