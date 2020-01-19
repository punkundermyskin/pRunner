//
//  ProgresCircle.swift
//  pRunner
//
//  Created by pennyworth on 12/14/19.
//  Copyright © 2019 punkundermyskin. All rights reserved.
//

import UIKit

class ProgresCircle: UIView {
    
    let shapeLayer = CAShapeLayer()
    static let radius = CGFloat(65)
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        textField.text = "TEST"
        textField.font = UIFont.boldSystemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let percentTextField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        textField.text = "0%"
        textField.font = UIFont.boldSystemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = UIColor.rgb(red: 45, green: 45, blue: 45)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        addSubview(titleTextField)
        titleTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        addSubview(percentTextField)
        percentTextField.bottomAnchor.constraint(equalTo: titleTextField.topAnchor, constant: -5).isActive = true
        percentTextField.centerXAnchor.constraint(equalTo: titleTextField.centerXAnchor).isActive = true
        let center = self.center
        
        let trackLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: ProgresCircle.radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        shapeLayer.strokeEnd = 0
        
        layer.addSublayer(shapeLayer)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    @objc private func handleTap() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
}
