//
//  MapCell.swift
//  pRunner
//
//  Created by pennyworth on 11/9/19.
//  Copyright © 2019 punkundermyskin. All rights reserved.
//

import UIKit
import MapKit

class MapCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let topSectionLine: UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 108, green: 108, blue: 108)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomSectionLine: UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(red: 108, green: 108, blue: 108)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        return mapView
    }()
    
    func setupView() {
        addSubview(MapCell.mapView)
        MapCell.mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        MapCell.mapView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        MapCell.mapView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        MapCell.mapView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        addSubview(topSectionLine)
        topSectionLine.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topSectionLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        topSectionLine.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        addSubview(bottomSectionLine)
        bottomSectionLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomSectionLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bottomSectionLine.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
    }
}


