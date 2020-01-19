//
//  StatsCell.swift
//  pRunner
//
//  Created by pennyworth on 11/12/19.
//  Copyright © 2019 punkundermyskin. All rights reserved.
//

import UIKit

class StatsCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "statCellId"
    
    let statsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
//        backgroundColor = .red
        statsCollectionView.dataSource = self
        statsCollectionView.delegate = self
        statsCollectionView.register(StatCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(statsCollectionView)
        statsCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        statsCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        statsCollectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        statsCollectionView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 6
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StatCell
         return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
     }

}

class StatCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.rgb(red: 108, green: 108, blue: 108).cgColor
        layer.cornerRadius = 10
//        clipsToBounds = true
        backgroundColor = .rgb(red: 73, green: 73, blue: 73)
    }
}
