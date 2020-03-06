//
//  LaunchScreenViewController.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/24/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit


class LaunchScreenViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delay(0.4, closure: {})
    }
    
    
    
    func delay(_ delay: Double, closure: @escaping () -> ()) {
        let time = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: time, execute: closure)
    }
}
