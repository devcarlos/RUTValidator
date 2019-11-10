//
//  ViewController.swift
//  Example
//
//  Created by Carlos Alcala on 11/9/19.
//  Copyright © 2019 ChileUtils. All rights reserved.
//

import ChileanRutUtils
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //quick validation using the RUTValidator
        let unformattedRut = "144004019"
        let isValid = RUTValidator.validRut(unformattedRut)
        
        if isValid {
            print("Valid RUT")
        } else {
            print("Invalid RUT")
        }
    }
}

