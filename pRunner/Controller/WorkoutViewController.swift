//
//  WorkoutViewController.swift
//  pRunner
//
//  Created by pennyworth on 11/21/19.
//  Copyright © 2019 punkundermyskin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class WorkoutViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var userPinView: MKAnnotationView!
    
    private let shapeLayer = CAShapeLayer()
    
    var time = 0.0
    var timer = Timer()
    
    private let resultViewController = ResultViewController()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        return mapView
    }()
    
    let finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Finish", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor.rgb(red: 210, green: 47, blue: 47)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(finishWorkout), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let leftStatusView: UIView = {
        let view = ProgresCircle()
        view.shapeLayer.strokeColor = UIColor.rgb(red: 83, green: 231, blue: 255).cgColor
        view.titleTextField.text = "Distance"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rightStatusView: UIView = {
        let view = ProgresCircle()
        view.shapeLayer.strokeColor = UIColor.rgb(red: 248, green: 83, blue: 255).cgColor
        view.titleTextField.text = "Colories"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.systemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupMap()
    }
    
    private func setupViews() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        view.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(finishButton)
        finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        finishButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        finishButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        finishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        setupCircles()
        
        startTimer()
    }
    
    func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func UpdateTimer() {
        time = time + 0.1
        
        let hours = Int(time) / (6000 * 60) % 24
        let minutes = Int(time) / 6000 % 60
        let seconds = Int(time) / 100 % 60
//        let ms = Int(time) % 100
        
        timeLabel.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    private func setupCircles() {
        
        view.addSubview(leftStatusView)
        let radius = ProgresCircle.radius
//        leftStatusView.backgroundColor = .white
        leftStatusView.bottomAnchor.constraint(equalTo: finishButton.topAnchor, constant: -radius - 10).isActive = true
        leftStatusView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: radius + 10).isActive = true
        leftStatusView.widthAnchor.constraint(equalToConstant: 5).isActive = true
        leftStatusView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        
        view.addSubview(rightStatusView)
//        rightStatusView.backgroundColor = .white
        rightStatusView.bottomAnchor.constraint(equalTo: finishButton.topAnchor, constant: -radius - 10).isActive = true
        rightStatusView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -radius - 10).isActive = true
        rightStatusView.widthAnchor.constraint(equalToConstant: 5).isActive = true
        rightStatusView.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }

    @objc private func finishWorkout() {
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
}

//// MARK: - CLLocationManagerDelegate,MKMapViewDelegate

extension WorkoutViewController: CLLocationManagerDelegate,MKMapViewDelegate  {
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
        mapView.showsUserLocation = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
        mapView.pointOfInterestFilter = .excludingAll
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation {
//            let pin = mapView.view(for: annotation) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
//            pin.image = UIImage(named: "location")
//            userPinView = pin
//            return pin
//
//        } else {
//            // handle other annotations
//        }
//        return nil
//    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        mapView.mapType = MKMapType.mutedStandard

        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: false)
    }
}
