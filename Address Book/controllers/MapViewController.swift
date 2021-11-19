//
//  MapViewController.swift
//  Address Book
//
//  Created by Admin on 17.11.2021.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit
import YandexMapsMobile
import CoreGraphics

class MapViewController: UIViewController {
    
    var location = YMKMapKit.sharedInstance().createLocationManager()
    private var places: [Place] = []
    
    private lazy var mapView: YMKMapView = {
        let view = YMKMapView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchBarLabel: UILabel = {
        let search = UILabel()
        search.text = "Поиск"
        search.textColor = .systemGray
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var speakImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Action")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var searchImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Search_Icon")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var swipeGecture: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .down
        swipe.numberOfTouchesRequired = 1
        return swipe
    }()
    
    private lazy var viewMenu: UIView = {
        var menu = UIView(frame: CGRect(x: .zero, y: view.frame.height, width: view.frame.width, height: view.frame.height))
        menu.backgroundColor = .white
        return menu
    }()

    private lazy var gpsView: GPSView = GPSView()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var searchBar: UISearchTextField = {
        let search = UISearchTextField()
        search.placeholder = "Поиск"
        search.backgroundColor = .systemGray6
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.separatorStyle = .singleLine
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return table
    }()
    
    private lazy var popoverArrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Popover_Arrow")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location.requestSingleUpdate(withLocationListener: self)
        setupMapView()
        data()
    }
    
    private func setupMapView() {
        
        view.addSubview(mapView)
        view.addSubview(gpsView)
        view.addSubview(searchView)
        
        searchView.addSubview(searchBarView)
        searchView.addSubview(searchButton)
        
        searchBarView.addSubview(searchBarLabel)
        searchBarView.addSubview(speakImage)
        searchBarView.addSubview(searchImage)
        
        viewMenu.addSubview(headerView)
        headerView.addSubview(searchBar)
        viewMenu.addSubview(tableView)
        viewMenu.addSubview(popoverArrowView)
        
        searchButton.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        
        swipeGecture.addTarget(self, action: #selector(swipeViewMenuAction))
        viewMenu.addGestureRecognizer(swipeGecture)
        
        view.addSubview(viewMenu)
        
        tableView.register(SearchResultsTableViewCell.self, forCellReuseIdentifier: SearchResultsTableViewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        
        
        
        NSLayoutConstraint.activate([
            
            // popoverArrowView
            popoverArrowView.centerXAnchor.constraint(equalTo: viewMenu.centerXAnchor),
            popoverArrowView.topAnchor.constraint(equalTo: viewMenu.topAnchor),
            
            // tableView
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: viewMenu.bottomAnchor, constant: -8),
            tableView.leadingAnchor.constraint(equalTo: viewMenu.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: viewMenu.trailingAnchor),
            
            // headerView
            headerView.topAnchor.constraint(equalTo: popoverArrowView.bottomAnchor, constant: 8),
            headerView.leadingAnchor.constraint(equalTo: viewMenu.leadingAnchor, constant: 8),
            headerView.trailingAnchor.constraint(equalTo: viewMenu.trailingAnchor, constant: -8),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            // searchBar
            searchBar.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8),
            
            // mapView
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // searchView
            searchView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            searchView.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 40),
            searchView.heightAnchor.constraint(lessThanOrEqualToConstant: 50),
            searchView.widthAnchor.constraint(equalToConstant: 300),
            
            // searchBarView
            searchBarView.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 8),
            searchBarView.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 8),
            searchBarView.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -8),
            searchBarView.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -8),
            searchBarView.heightAnchor.constraint(equalToConstant: 34),
            
            // searchImage
            searchImage.topAnchor.constraint(equalTo: searchBarView.topAnchor),
            searchImage.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor, constant: 8),
            searchImage.bottomAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            
            // speakImage
            speakImage.topAnchor.constraint(equalTo: searchBarView.topAnchor),
            speakImage.trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor, constant: -8),
            speakImage.bottomAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            
            // searchBarLabel
            searchBarLabel.centerYAnchor.constraint(equalTo: searchBarView.centerYAnchor),
            searchBarLabel.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 8),
            searchBarLabel.trailingAnchor.constraint(equalTo: speakImage.leadingAnchor, constant: -8),
            
            // searchButton
            searchButton.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 8),
            searchButton.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 8),
            searchButton.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -8),
            searchButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -8),
            searchButton.heightAnchor.constraint(equalToConstant: 34),
            
            // gpsView
            gpsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.gpsViewBottom),
            gpsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.gpsViewTrailing),
            gpsView.heightAnchor.constraint(equalToConstant: Constants.gpsViewHeight),
            gpsView.widthAnchor.constraint(equalToConstant: Constants.gpsViewWidth),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        searchView.layer.cornerRadius = 10
        searchBarView.layer.cornerRadius = 10
        viewMenu.layer.cornerRadius = 20
      
    }
    
    @objc
    private func swipeViewMenuAction() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.searchView.alpha = 1
            self.viewMenu.frame.origin.y = self.view.frame.height
        }) { (completed) in
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "tabBarViewShow")))
        }
    }
    
    @objc
    private func searchButtonAction() {
        
        NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "tabBarView")))
        
        UIView.animate(withDuration: 0.3) {
            self.searchView.alpha = 0
            self.viewMenu.frame.origin.y = 40
        }
    }
}

extension MapViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.reuseId, for: indexPath) as! SearchResultsTableViewCell
        let place = places[indexPath.row]
        cell.nameLabel.text = place.title
        cell.addressLabel.text = place.address
        cell.distanceLabel.text = place.distance
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let place = places[indexPath.row]
        let alertController = UIAlertController(title: "Добавить адрес в исзбранное", message: place.title, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { (_) in
            CoreDataUtils.saveLocationFav(locationName: place.title, locationSub: place.address)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension MapViewController: YMKLocationDelegate {

    func onLocationUpdated(with location: YMKLocation) {
        mapView.mapWindow.map.move(
            with: YMKCameraPosition.init(target: location.position,
                                     zoom: 15, azimuth: 0, tilt: 0),
        animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
        cameraCallback: nil)
    }

    func onLocationStatusUpdated(with status: YMKLocationStatus) {
        switch status {
        case .available:
            location.resume()
        default:
            location.suspend()
        }
    }
}

extension MapViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func data() {
        for i in 1...10 {
            let place = Place(title: "Государственный музей истории \(i)", address: "Ташкент", distance: "100 км")
            places.append(place)
        }
    }
}
