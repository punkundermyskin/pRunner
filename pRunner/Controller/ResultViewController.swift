//
//  ResultViewController.swift
//  pRunner
//
//  Created by pennyworth on 12/15/19.
//  Copyright © 2019 punkundermyskin. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .rgb(red: 45, green: 45, blue: 45)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.hidesBackButton = true
    }
}
