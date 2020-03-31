//
//  AddMySpotViewControllerExt.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/19/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Explicit Instances
/*
    ***FACTORY METHODS***
 
    NOTE: This extension will take care of creating views
 
*/
extension AddSpotViewController {
    func createImageTitleLabel() -> Label {
        let label = Label.newLabel(title: "Add an image to this spot", textColor: .darkGray, textSize: 19)
        let labelHeight = label.optimalHeight
        label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.width, height: labelHeight)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .init(5))
        return label
    }
    
    func createSpotImageContainer() -> View {
        let view = View.initView(backgroundColor: .darkGray)
        view.layer.cornerRadius = 25
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressedAddImage)))
        return view
    }
    
    func createSpotImage() -> ImageView {
        let image = ImageView.initImage(name: "image")
        image.layer.cornerRadius = 25
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressedAddImage)))
        return image
    }
    
    func createSpotNickNameLabel() -> Label {
        let label = Label.newLabel(title: "Give this spot a nickename", textColor: .darkGray, textSize: 19)
        let labelHeight = label.optimalHeight
        label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.width, height: labelHeight)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .init(5))
        return label
    }
    
    func createNickNameTextfield() -> TextField {
        let textField = TextField.initTextBox(.clear, .darkGray, .darkGray, 0, .clear, "Nickname", 17)
        return textField
    }
    
    func createTextFieldBottomLine() -> View {
        let view = View.initView(backgroundColor: .darkGray)
        return view
    }
    
    func createVerifySpotTitleLabel() -> Label {
        let label = Label.newLabel(title: "Verify this spot", textColor: .darkGray, textSize: 19)
        label.font = UIFont.systemFont(ofSize: 18, weight: .init(5))
        return label
    }
    
    func createSecruityImage() -> ImageView {
        let image = ImageView.initImage(name: "security")
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressedVerifyImage)))
        image.tag = 1
        return image
    }
    
    func createTheifImage() -> ImageView {
        let image = ImageView.initImage(name: "thief")
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressedVerifyImage)))
        image.tag = 2
        return image
    }
    
    func createConstructionImage() -> ImageView {
        let image = ImageView.initImage(name: "construction")
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressedVerifyImage)))
        image.tag = 3
        return image
    }
    
    func createPositiveHandImage() -> ImageView {
        let image = ImageView.initImage(name: "positive")
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressedVerifyImage)))
        image.tag = 4
        return image
    }
    
    func createStackView() -> Stack {
        let stackView = Stack.createStackView(with: [secruityImage, theifImage, constructionImage, positiveHandImage], alignment: .center, distribution: .fillEqually, axis: .horizontal, spacing: 10)
        return stackView
    }
}


// MARK: - Layouts
/*
  NOTE: This extension will take of layingout subViews
*/
extension AddSpotViewController {
    
    // NOTE: This is going to be the main caller function for layingout all subviews
    func layout() {
        layoutImageTitleLabel()
        layoutStackView()
        layoutVerifySpotTitleLabel()
        layoutSpotNickNameLabel()
        layoutNickNameTextfield()
        layoutTextFieldBottomLine()
        layoutSpotImageContainer()
        layoutSpotImage()
        
    }
    
    func layoutImageTitleLabel() {
        view.add(subview: imageTitleLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            v.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            v.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -35)
            ]}
    }
    
    func layoutSpotImageContainer() {
        view.add(subview: spotImageContainer) { (v, p) in [
            v.topAnchor.constraint(equalTo: imageTitleLabel.bottomAnchor, constant: 25),
            v.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            v.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            v.bottomAnchor.constraint(equalTo: spotNickNameLabel.topAnchor, constant: -50)
            ]}
    }
    
    func layoutSpotImage() {
        spotImageContainer.add(subview: spotImage) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: spotImageContainer.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: spotImageContainer.centerYAnchor),
            v.heightAnchor.constraint(equalToConstant: 130),
            v.widthAnchor.constraint(equalToConstant: 150)
            ]}
    }
    
    func layoutSpotNickNameLabel() {
        view.add(subview: spotNickNameLabel) { (v, p) in [
            v.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            v.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            ]}
    }
    
    func layoutNickNameTextfield() {
        view.add(subview: nickNameTextfield) { (v, p) in [
            v.topAnchor.constraint(equalTo: spotNickNameLabel.bottomAnchor, constant: 25),
            v.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            v.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            v.bottomAnchor.constraint(equalTo: verifySpotTitleLabel.topAnchor, constant: -50),
            v.heightAnchor.constraint(equalToConstant: 30),
            ]}
    }
    
    func layoutTextFieldBottomLine() {
        view.add(subview: textFieldBottomLine) { (v, p) in [
            v.topAnchor.constraint(equalTo: nickNameTextfield.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            v.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            v.heightAnchor.constraint(equalToConstant: 3)
            ]}
    }
    
    // NOTE: stackView has to be constraint before verifySpotTitleLabel
    func layoutVerifySpotTitleLabel() {
        view.add(subview: verifySpotTitleLabel) { (v, p) in [
            v.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            v.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            v.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -25)
            ]}
    }
    
    
    
    func layoutStackView() {
        view.add(subview: stackView) { (v, p) in [
            v.leadingAnchor.constraint(equalTo: p.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            v.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            v.heightAnchor.constraint(equalToConstant: 80),
            v.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -150)
            ]}
    }
}

