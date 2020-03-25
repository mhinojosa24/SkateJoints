//
//  AddMySpotView.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 3/23/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit


final class AddSpotView: UIView {
    
    lazy var imageTitleLabel: Label = self.createImageTitleLabel()
    lazy var spotImageContainer: View = self.createSpotImageContainer()
    lazy var spotImage: ImageView = self.createSpotImage()
    lazy var spotNickNameLabel: Label = self.createSpotNickNameLabel()
    lazy var nickNameTextfield: TextField = self.createNickNameTextfield()
    lazy var textFieldBottomLine: View = self.createTextFieldBottomLine()
    lazy var verifySpotTitleLabel: Label = self.createVerifySpotTitleLabel()
    lazy var secruityImage: ImageView = self.createSecruityImage()
    lazy var theifImage: ImageView = self.createTheifImage()
    lazy var constructionImage = self.createConstructionImage()
    lazy var positiveHandImage: ImageView = self.createPositiveHandImage()
    lazy var stackView: Stack = self.createStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI(view: self)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(view: UIView) {
        view.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1803921569, blue: 0.2745098039, alpha: 1)
    }
}
