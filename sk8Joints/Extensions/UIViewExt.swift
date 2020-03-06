//
//  UIViewExt.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/19/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    // NOTE: This function gives any view a shadow affect
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.30
        layer.shadowOffset = CGSize(width: 0.0, height: 9.0)
        layer.shadowRadius = 3
    }
    
    // NOTE: This funciton gives a custom shadow effect to target UIView
    func addCustomShadow(shadowColor: UIColor, shadowOpacity: Float, shadowOffsetWidth: Double, shadowOffsetHeight: Double) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
    }


    
    // NOTE: This helper method creates and contraints to views
    func add(subview: UIView, createConstraints: (_ view: UIView, _ parent: UIView) -> [NSLayoutConstraint]) {
        addSubview(subview)
        
        subview.activate(constraints: createConstraints(subview, self))
        subview.layoutIfNeeded()
    }
    
    func add(subview: UIView, sendViewToBack: Bool, createConstraints: (_ view: UIView, _ parent: UIView) -> [NSLayoutConstraint]) {
        addSubview(subview)
        
        if sendViewToBack == true {
            sendSubviewToBack(subview)
        }
        
        subview.activate(constraints: createConstraints(subview, self))
    }
    
    // NOTE: This funciton activates the given constraints
    func activate(constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    
}
