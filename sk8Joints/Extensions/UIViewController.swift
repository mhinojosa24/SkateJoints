//
//  UIViewController.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/22/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit

fileprivate var aView: UIView?
fileprivate var blurEffectView: UIVisualEffectView?

extension UIViewController {
    
    func showSpinner() {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView!)
        aView = UIView(frame: self.view.frame)
//        aView?.backgroundColor = UIColor.init(red: 29, green: 68, blue: 101, alpha: 0.5)
//        aView?.alpha = 0.5
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = aView!.center
        activityIndicator.startAnimating()
        aView?.addSubview(activityIndicator)
        self.view.addSubview(aView!)
    }
    
    func removeSpinner() {
        blurEffectView?.removeFromSuperview()
        aView?.removeFromSuperview()
        blurEffectView = nil
        aView = nil
    }
}
