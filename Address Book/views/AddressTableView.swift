//
//  AddressTableView.swift
//  Address Book
//
//  Created by Admin on 17.11.2021.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

protocol Favorite {
    func getLocations() -> [LocationFav]
}

class AddressTableView: UITableView {
    
    var delegateFav: Favorite?
    private var favoritePlases: [LocationFav] = []
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .systemGray5
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        self.register(AddressTableViewCell.self, forCellReuseIdentifier: AddressTableViewCell.reuseId)
        self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 70))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddressTableView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let favoritePlases = self.delegateFav?.getLocations() else {
            return 0
        }
        self.favoritePlases = favoritePlases
        return favoritePlases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.reuseId, for: indexPath) as! AddressTableViewCell
        cell.locationNameLabel.text = favoritePlases[indexPath.row].locationName
        cell.locationLabel.text = favoritePlases[indexPath.row].locationSubname
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removePlace = favoritePlases[indexPath.row]
            CoreDataUtils.deleteLocationFav(locationFav: removePlace)
            favoritePlases.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
