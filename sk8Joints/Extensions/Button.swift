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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, fontSize: CGFloat = CGFloat(16), titleColor: UIColor, cornerRadius: CGFloat, backgroundColor: UIColor, target: Any?, action: Selector, event: UIControl.Event) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.addTarget(target, action: action, for: event)
        self.isEnabled = true
    }
}
