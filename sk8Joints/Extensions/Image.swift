//
//  Image.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/19/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit


class ImageView: UIImageView {
    
    public static func initImage(name: String) -> ImageView {
        let image = UIImage(named: name)
        let imageView = ImageView(image: image)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
