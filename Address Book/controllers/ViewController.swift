//
//  ViewController.swift
//  Address Book
//
//  Created by Admin on 16.11.2021.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    private var mapViewController: UIViewController?
    private var addressViewController: UIViewController?
    private var tabBarView: TabBarView = TabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tabBarView)
        setupTabBarView()
        
        mapViewController = MapViewController()
        view.insertSubview(self.mapViewController!.view, at: 0)
        addChild(self.mapViewController!)
        mapViewController?.didMove(toParent: self)
        tabBarView.mapButton.setImage(UIImage(named: "location_Icon_Selected"), for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tabBarViewAction), name: NSNotification.Name("tabBarView"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tabBarViewShowAction), name: NSNotification.Name("tabBarViewShow"), object: nil)
    }
    
    @objc
    private func tabBarViewAction() {
        tabBarView.alpha = 0
    }
    
    @objc
    private func tabBarViewShowAction() {
        tabBarView.alpha = 1
    }
    
    private func setupTabBarView() {
        NSLayoutConstraint.activate([
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.tabBarCornerRadius),
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: Constants.tabBarHeight)
        ])
        
        tabBarView.mapButton.addTarget(self, action: #selector(configureMapViewController), for: .touchUpInside)
        tabBarView.markButton.addTarget(self, action: #selector(configureAddressViewController), for: .touchUpInside)
    }
    
    @objc
    private func configureMapViewController() {
        
        guard let addressViewController = addressViewController else { return }
        
        if children.contains(addressViewController) {
            self.addressViewController?.willMove(toParent: nil)
            self.addressViewController?.view.removeFromSuperview()
            self.addressViewController?.removeFromParent()
            
            mapViewController = MapViewController()
            view.insertSubview(self.mapViewController!.view, at: 0)
            addChild(self.mapViewController!)
            mapViewController?.didMove(toParent: self)
            
            tabBarView.markButton.setImage(UIImage(named: "bookmark_Icon"), for: .normal)
            tabBarView.mapButton.setImage(UIImage(named: "location_Icon_Selected"), for: .normal)
        }
    }
    
    @objc
    private func configureAddressViewController() {
        
        guard let mapViewController = mapViewController else { return }
        
        if children.contains(mapViewController) {
            self.mapViewController?.willMove(toParent: nil)
            self.mapViewController?.view.removeFromSuperview()
            self.mapViewController?.removeFromParent()
            
            addressViewController = UINavigationController(rootViewController: AddressViewController())
            view.insertSubview(addressViewController!.view, at: 0)
            addChild(addressViewController!)
            addressViewController?.didMove(toParent: self)
            
            tabBarView.markButton.setImage(UIImage(named: "bookmark_Icon_Selected"), for: .normal)
            tabBarView.mapButton.setImage(UIImage(named: "location_Icon_Tab"), for: .normal)
        }
    }
}

