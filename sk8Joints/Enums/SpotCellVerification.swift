//
//  SpotCellImage.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 2/20/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit

enum verificationImage {
    case thumbsUp
    case security
    case construction
    case theif
    
    var imageToCell : UIImage {
        switch self {
        case .thumbsUp:
            return UIImage(named: "positive")!
        case .security:
            return UIImage(named: "security")!
        case .construction:
            return UIImage(named: "construction")!
        case .theif:
            return UIImage(named: "thief")!
        }
    }
}
