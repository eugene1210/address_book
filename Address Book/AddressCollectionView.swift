//
//  AddressTableView.swift
//  Address Book
//
//  Created by Admin on 17.11.2021.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class AddressTableView: UITableView {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.backgroundColor = .red
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.delegate = self
        self.dataSource = self
        
        self.register(AddressTableViewCell.self, forCellWithReuseIdentifier: AddressTableViewCell.reuseId)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AddressTableView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressCollectionViewCell", for: indexPath) as! AddressTableViewCell
        cell.nameLabel.text = "1"
        return cell
    }
}

extension AddressTableView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width - 20, height: self.frame.height / 7)
    }
}
