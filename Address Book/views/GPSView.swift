//
//  GPSView.swift
//  Address Book
//
//  Created by Admin on 17.11.2021.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class GPSView: UIView {
    
    private let arrowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Location_Icon"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(arrowButton)
        self.arrowButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -2).isActive = true
        self.arrowButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 2).isActive = true
        
        self.arrowButton.addTarget(self, action: #selector(arrowButtonTapped), for: .touchUpInside)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.layer.frame.width / 2
    }
    
    @objc
    private func arrowButtonTapped() {
        print("arrowButtonTapped")
    }
}
