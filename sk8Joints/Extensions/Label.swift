//
//  Label.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/19/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit


class Label: UILabel {
    
    
    public static func newLabel(title: String, textColor: UIColor, textSize: CGFloat) -> Label {
        let label = Label()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = textColor
        label.text = title
        label.font = UIFont.systemFont(ofSize: textSize)
        
        return label
    }
}

extension Label {
    var optimalHeight: CGFloat {
        let label = Label(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        return label.frame.height
    }
}
