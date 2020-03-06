//
//  View.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/19/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//
import Foundation
import UIKit


class View: UIView {
    
    public static func initView(backgroundColor: UIColor) -> View {
        let view = View()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
        
        return view
    }
}
