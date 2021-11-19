//
//  SearchResultsTableViewCell.swift
//  Address Book
//
//  Created by Admin on 18.11.2021.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    
    static let reuseId = "SearchResultsTableViewCell"
    
    private lazy var imageViewIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "Fav_Icon")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .systemGray3
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGray3
        label.textAlignment = .right
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.addSubview(imageViewIcon)
        containerView.addSubview(addressLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(distanceLabel)
        contentView.addSubview(containerView)
       
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        NSLayoutConstraint.activate([
            
            // containerView
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // imageViewIcon
            imageViewIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageViewIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            imageViewIcon.widthAnchor.constraint(equalToConstant: 24),
            
            // nameLabel
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: imageViewIcon.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: distanceLabel.leadingAnchor, constant: -16),
            
            // distanceLabel
            distanceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            distanceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            // addressLabel
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: imageViewIcon.trailingAnchor, constant: 16),
            addressLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }
}
