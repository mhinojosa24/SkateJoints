//
//  LoginSignUpView.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/19/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit


class LoginSignupView: UIView {
    
    lazy var containerView: View = self.createContainerView()
    lazy var logoImage: ImageView = self.createImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension LoginSignupView {
    
    func createContainerView() -> View {
        let view = View.initView(backgroundColor: .red)
        
        return view
    }
    
    func createImage() -> ImageView {
        let image = ImageView.initImage(name: "logo")
        
        return image
    }
}


extension LoginSignupView {
    
    func layout() {
        layoutContainerView()
        layoutLogoImage()
    }
    
    func layoutContainerView() {
        addSubview(containerView)
    }
    
    func layoutLogoImage() {
        addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
//        logoImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)
    }
}

