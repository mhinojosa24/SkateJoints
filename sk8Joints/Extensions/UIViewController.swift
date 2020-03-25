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
        DispatchQueue.main.async {
            self.view.addSubview(blurEffectView!)
            aView = UIView(frame: self.view.frame)
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.color = .white
            activityIndicator.center = aView!.center
            activityIndicator.startAnimating()
            aView?.addSubview(activityIndicator)
            self.view.addSubview(aView!)
        }
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            blurEffectView?.removeFromSuperview()
            aView?.removeFromSuperview()
            blurEffectView = nil
            aView = nil
        }
    }
}
