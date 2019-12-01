//
//  Utilities.swift
//  pRunner
//
//  Created by pennyworth on 11/3/19.
//  Copyright © 2019 punkundermyskin. All rights reserved.
//

import UIKit

class Utilities {
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}
