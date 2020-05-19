//
//  MySpotCollectionViewCell.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/19/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import Kingfisher

final class MySpotCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "mySpotCellId"
    lazy var spotImageView: UIImageView = self.createSpotImageView()
    lazy var spotTitle: Label = self.createSpotTitle()
    lazy var spotAddressLabel: Label = self.createSpotAddressLabel()
    lazy var verifyLogoIndicator: UIImageView = self.createVerifyLogoIndicator()
    lazy var navigationLogo: Button = self.createNavigationLogo()
    lazy var initiateNavigationButton: Button = self.createNavigationButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCellUI()
        layout()
        navigationLogo.isUserInteractionEnabled = true
        initiateNavigationButton.isUserInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //spotImageView.image = nil
        spotTitle.text = ""
        spotAddressLabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCellUI() {
        self.addCustomShadow(shadowColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), shadowOpacity: 3.0, shadowOffsetWidth: 0.0, shadowOffsetHeight: 3.0)
        layer.cornerRadius = 25
    }
    
    func configureCell(spot: Spot) {
        
        let imageURL = URL(string: spot.spotImage!)
        initiateNavigationButton.isHidden = true
        spotImageView.contentMode = .scaleAspectFill
        spotImageView.kf.indicatorType = .activity
        DispatchQueue.main.async {
            self.spotImageView.kf.setImage(with: imageURL, placeholder: nil, options: [.transition(.fade(0.5)), .processor(BlurImageProcessor(blurRadius: 1.0))], progressBlock: nil) { (results) in
                switch results {
                case .success:
                    self.spotTitle.text = spot.spotName
                    self.spotAddressLabel.text = spot.address
                    self.navigationLogo.setBackgroundImage(UIImage(named: "navigate"), for: .normal)
                    switch spot.verifySpot! {
                    case 1:
                        self.verifyLogoIndicator.image = verificationImage.security.imageToCell
                        break
                    case 2:
                        self.verifyLogoIndicator.image = verificationImage.theif.imageToCell
                        break
                    case 3:
                        self.verifyLogoIndicator.image = verificationImage.construction.imageToCell
                        break
                    case 4:
                        self.verifyLogoIndicator.image = verificationImage.thumbsUp.imageToCell
                        break
                    default:
                        let image = UIImage(named: "image")!
                        self.verifyLogoIndicator.image = image
                    }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}


extension MySpotCollectionViewCell {
    
    func createSpotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func createSpotTitle() -> Label {
        let label = Label.newLabel(title: "", textColor: #colorLiteral(red: 0.9294117647, green: 0.7058823529, blue: 0.1647058824, alpha: 1), textSize: 18)
        label.font = UIFont.systemFont(ofSize: 20, weight: .init(15))
        return  label
    }
    
    func createSpotAddressLabel() -> Label {
        let label = Label.newLabel(title: "", textColor: .white, textSize: 16)
        let labelHeight = label.optimalHeight
        label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.width, height: labelHeight)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }
    
    func createVerifyLogoIndicator() -> UIImageView {
        let imageView = UIImageView()
        return imageView
    }
    
    func createNavigationLogo() -> Button {
        let button = Button()
        button.backgroundColor = .clear
        return button
    }
    
    func createNavigationButton() -> Button {
        let button = Button()
        button.backgroundColor = .clear
        return button
    }
}


extension MySpotCollectionViewCell {
    
    func layout() {
        layoutSpotImage()
        layoutVerifyLogoIndicator()
        layoutSpotTitle()
        layoutNavigationButton()
        layoutDirectionButton()
        layoutSpotAddressLabel()
    }
    
    
    func layoutSpotImage() {
        contentView.addSubview(spotImageView)
        spotImageView.clipsToBounds = true
        spotImageView.frame = self.bounds
        spotImageView.layer.cornerRadius = 25
     
    }
    
    func layoutVerifyLogoIndicator() {
        add(subview: verifyLogoIndicator) { (v, p) in [
            v.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            v.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            v.heightAnchor.constraint(equalToConstant: 25),
            v.widthAnchor.constraint(equalToConstant: 25)
            ]}
    }
    
    func layoutSpotTitle() {
        add(subview: spotTitle) { (v, p) in [
            v.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            v.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            v.trailingAnchor.constraint(equalTo: verifyLogoIndicator.leadingAnchor, constant: 40)
            ]}
    }
    
    func layoutNavigationButton() {
        add(subview: navigationLogo) { (v, p) in [
            v.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            v.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            v.heightAnchor.constraint(equalToConstant: 40),
            v.widthAnchor.constraint(equalToConstant: 40)
            ]}
    }
    
    func layoutDirectionButton() {
        add(subview: initiateNavigationButton) { (v, p) in [
            v.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            v.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            v.heightAnchor.constraint(equalToConstant: 40),
            v.widthAnchor.constraint(equalToConstant: 40)
            ]}
    }
    
    func layoutSpotAddressLabel() {
        add(subview: spotAddressLabel) { (v, p) in [
            v.topAnchor.constraint(equalTo: spotTitle.bottomAnchor, constant: 40),
            v.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            v.trailingAnchor.constraint(equalTo: navigationLogo.leadingAnchor, constant: -20),
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -30)
            ]}
    }
}

