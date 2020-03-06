//
//  Button.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/19/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit



// NOTE: this is a custom button class
class Button: UIButton {
    
    // NOTE: function allows to make a custom buttom
    public static func initButton(title: String, titleSize: CGFloat = CGFloat(16), boldText: CGFloat = CGFloat(0), titleColor: UIColor, cornerRadius: CGFloat, backgroundColor: UIColor) -> Button {
        let button = Button(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        //guard let boldText = boldText else { return button}
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: boldText)
        button.titleLabel?.font = UIFont.systemFont(ofSize: titleSize)
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = cornerRadius
        
        
        return button
    }
}
