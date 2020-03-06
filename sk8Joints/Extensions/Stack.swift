//
//  Stack.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/19/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit


class Stack: UIStackView {
    
    public static func createStackView(with views: [UIView], alignment: UIStackView.Alignment, distribution: Distribution, axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> Stack {
        let stackView = Stack(arrangedSubviews: views)
        stackView.distribution = distribution
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.spacing = spacing
        
        
        return stackView
    }
}
