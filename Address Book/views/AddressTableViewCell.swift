//
//  AddressTableViewCell.swift
//  Address Book
//
//  Created by Admin on 17.11.2021.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    static let reuseId = "AddressTableViewCell"

    private let viewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageViewIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "Fav_Icon")
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let locationNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.locationNameLabel, self.locationLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(viewCell)
        self.contentView.backgroundColor = .systemGray5
        self.viewCell.addSubview(imageViewIcon)
        self.viewCell.addSubview(stackView)

        viewCell.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        viewCell.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        viewCell.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        viewCell.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
        
        NSLayoutConstraint.activate([
            imageViewIcon.centerYAnchor.constraint(equalTo: viewCell.centerYAnchor),
            imageViewIcon.trailingAnchor.constraint(equalTo: viewCell.trailingAnchor, constant: -16),
            imageViewIcon.topAnchor.constraint(equalTo: viewCell.topAnchor, constant: 8),
            imageViewIcon.bottomAnchor.constraint(equalTo: viewCell.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: viewCell.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: imageViewIcon.leadingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: viewCell.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: viewCell.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        viewCell.layer.cornerRadius = 10
    }
}
