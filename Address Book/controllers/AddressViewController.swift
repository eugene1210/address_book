//
//  AddressViewController.swift
//  Address Book
//
//  Created by Admin on 17.11.2021.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {

    private var addressTableView = AddressTableView()
    private var locationFavs: [LocationFav] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Мои адреса"
        view.backgroundColor = .systemGray6
        
        locationFavs = getLocations()
        addressTableView.delegateFav = self

        view.addSubview(addressTableView)
        setupTableView()
        addressTableView.delegateFav = self
    }
    
    private func setupTableView() {
        addressTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        addressTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addressTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addressTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension AddressViewController: Favorite {
    
    func getLocations() -> [LocationFav] {
        let places = CoreDataUtils.fetchLocationFavs()
        return places
    }
}
