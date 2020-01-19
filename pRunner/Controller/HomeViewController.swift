//
//  HomeViewController.swift
//  pRunner
//
//  Created by pennyworth on 11/3/19.
//  Copyright © 2019 punkundermyskin. All rights reserved.
//

import UIKit
import SwiftUI
import MapKit
import CoreLocation

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let headerID = "headerID"
    private let mapCellID = "mapCellID"
    private let friendsCellID = "friendsCellID"
    private let StatsCellID = "StatsCellID"
    private let RunCellID = "RunCellID"
    
    private let locationManager = CLLocationManager()
    private let mapView = MapCell.mapView
    private let workoutViewController = WorkoutViewController()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "tayli"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        let image = UIImage(named: "icons8-menu-24")
        button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let userProfileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        let image = UIImage(named: "taylor")
        imageView.image = image
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 40 / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let friendsView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .rgb(red: 45, green: 45, blue: 45)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.transform = CGAffineTransform(rotationAngle: CGFloat(-15.0 * Double.pi/180));
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        overrideUserInterfaceStyle = .dark
//        self.navigationController?.pushViewController(workoutViewController, animated: true)
        setupNavBar()
        setupCollectionView()
        setupMap()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIColor.clear.as1ptImage(), for: .default)

        navigationController?.navigationBar.shadowImage = UIColor.rgb(red: 108, green: 108, blue: 108).as1ptImage()

        navigationItem.titleView = usernameLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingsButton)
        navigationItem.leftBarButtonItem?.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openMenu)))
    
        guard let navbar = navigationController?.navigationBar else { return }
        navbar.addSubview(userProfileImage)
        userProfileImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        userProfileImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userProfileImage)
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .rgb(red: 45, green: 45, blue: 45)
        collectionView.register(FriendsCell.self, forCellWithReuseIdentifier: friendsCellID)
        collectionView.register(MapCell.self, forCellWithReuseIdentifier: mapCellID)
        collectionView.register(StatsCell.self, forCellWithReuseIdentifier: StatsCellID)
        collectionView.register(RunCell.self, forCellWithReuseIdentifier: RunCellID)
        
        collectionView.isScrollEnabled = false
    }
    
    @objc func openMenu() {
//    do stuff here
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: friendsCellID, for: indexPath) as! FriendsCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mapCellID, for: indexPath) as! MapCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatsCellID, for: indexPath) as! StatsCell
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RunCellID, for: indexPath) as! RunCell
            cell.button.addTarget(self, action: #selector(touchRunButton), for: .touchUpInside)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatsCellID, for: indexPath) as! StatsCell
            return cell
        }
    }
    
    @objc func touchRunButton() {
        self.navigationController?.pushViewController(workoutViewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
        return 4
    }
}

// MARK: - UICollectionViewFlowLayout

extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: 100)
        switch indexPath.section {
        case 0:
            return CGSize(width: view.frame.width, height: 76)
        case 1:
            return CGSize(width: view.frame.width, height: view.frame.height * 3/7)
        case 2:
            var height = view.frame.height * 4/7 - 65
            height -= 45 + 20 // run button
            height -= navigationController!.navigationBar.frame.height
            return CGSize(width: view.frame.width , height: height) // 250
//            return CGSize(width: 105 , height: 105)
        case 3:
            return CGSize(width: view.frame.width , height: 45)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 1:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case 2:
            return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        case 3:
            return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

// MARK: - CLLocationManagerDelegate,MKMapViewDelegate

extension HomeViewController: CLLocationManagerDelegate,MKMapViewDelegate  {
    private func setupMap() {
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        mapView.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: false)
    }
}
