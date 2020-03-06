//
//  Textfield.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/19/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit



class TextField: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // NOTE: creates a custom textfield without an image placeholder
    public static func initTextBox(_ backgroundColor: UIColor, _ textColor: UIColor, _ placeHolderTextColor: UIColor, _ borderWidth: CGFloat, _ borderColor: UIColor, _ placeHolder: String, _ textSize: CGFloat) -> TextField  {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor : placeHolderTextColor])
        textField.textColor = textColor
        textField.leftViewMode = .always
        textField.borderStyle = .none
        textField.layer.backgroundColor = backgroundColor.cgColor
        textField.font = UIFont.systemFont(ofSize: textSize)
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = borderWidth
        textField.layer.borderColor = borderColor.cgColor
        return textField
    }
    
}

