//
//  LoginView.swift
//  pRunner
//
//  Created by pennyworth on 11/3/19.
//  Copyright © 2019 punkundermyskin. All rights reserved.
//

import UIKit
import AVKit

class LoginView: UIView {
    
    let topContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "pRunner"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 15
        textField.attributedPlaceholder = NSAttributedString(string: "  Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 15
        textField.attributedPlaceholder = NSAttributedString(string: "  Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let bottomContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor.rgb(red: 210, green: 47, blue: 47)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let singUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.textColor = .systemGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.attributedText = NSAttributedString(string: "Create Account", attributes:
        [.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.rgb(red: 45, green: 45, blue: 45)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(bottomContainerView)
        
        bottomContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        bottomContainerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bottomContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        bottomContainerView.addSubview(emailTextField)
        emailTextField.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 10).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        bottomContainerView.addSubview(passwordTextField)
        passwordTextField.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        bottomContainerView.addSubview(singUpButton)
        singUpButton.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor).isActive = true
        singUpButton.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor, constant: -25).isActive = true
        singUpButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        singUpButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        bottomContainerView.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: singUpButton.topAnchor, constant: -20).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
}
