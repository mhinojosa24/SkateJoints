//
//  AddMySpotViewController.swift
//  SkateJoints
//
//  Created by Student Loaner 3 on 10/17/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import CoreLocation
import Mapbox
import MapboxGeocoder
import MapboxCoreNavigation


protocol UpdateSpotsDelegate {
    func shouldUpdateSpots(isEnableUpdate: Bool)
}

class AddSpotViewController: UIViewController, LocationUpdateDelegate {
    
    // NOTE: Explicitly being created when constraints are added
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
    var locationManager: LocationViewModel!
    var delegate: UpdateSpotsDelegate!
    var imageToSave: UIImage!
    var verifySpotTag: Int? = 0
    var address: String?
    var spotLat: Double?
    var spotLong: Double?
    private var viewModel: AddMySpotViewModel!
    
    init(viewModel: AddMySpotViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationUI()
        layout()
        viewModel.delegate = self
        viewModel.checkLocationServices()
    }
    
    func locationDidUpdate(location: CLLocation, address: String) {
        print(location.altitude)
        self.spotLat = location.coordinate.latitude
        self.spotLong = location.coordinate.longitude
        self.address = address
    }
    
    func locationError(error: LocationError) {
        switch error {
        case .denied, .restricted:
            let alert = UIAlertController(title: "Background Location Access Disabled", message: "In order to save gnarly spots we need your location.", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            alert.addAction(cancel)
            alert.addAction(openAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func saveNewSpot() {
        let spotIdentifier = Constant.databaseRef().childByAutoId().key
        guard let image = imageToSave else {
            showAlertAdvisor()
            navigationItem.rightBarButtonItem?.isEnabled = true
            return
        }
        
        guard
            let spotName = self.nickNameTextfield.text,
            let spotImageName = viewModel.getImageURL(image: image)?.absoluteString,
            let spotTag = self.verifySpotTag,
            let lat = self.spotLat,
            let long = self.spotLong,
            let address = self.address
            else { return }
        viewModel.validateSpot(spotName, spotImageName, spotTag) { (isValid) in
            if isValid {
                let newSpot = Spot(id: spotIdentifier, spotName: spotName, spotImage: spotImageName, address: address, spotLat: lat, spotLong: long, verifySpot: spotTag)
                self.viewModel.saveSpot(spot: newSpot) {
                    self.delegate.shouldUpdateSpots(isEnableUpdate: true)
                    self.viewModel.stopUpdatingLocation()
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                self.showAlertAdvisor()
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
    }
    
    
    
    private func showAlertAdvisor() {
        let alert = Constant.setupAlert(alertTitle: "Detected Empty Field", alertMessage: "Please enter all fields for a valid new spot", alertStyle: .alert, actionTitle: "OK", actionStyle: .cancel)
        present(alert, animated: true, completion: nil)
    }
    
    private func setUpNavigationUI() {
        title = viewModel.title
        let leftButton =  Button()
        leftButton.setTitle("Cancel", for: .normal)
        leftButton.setTitleColor(#colorLiteral(red: 0.9294117647, green: 0.7058823529, blue: 0.1647058824, alpha: 1), for: .normal)
        leftButton.addTarget(self, action: #selector(didPressCancelButton), for: .touchUpInside)
        
        let rightButton =  Button()
        rightButton.setTitle("Save", for: .normal)
        rightButton.setTitleColor(#colorLiteral(red: 0.9294117647, green: 0.7058823529, blue: 0.1647058824, alpha: 1), for: .normal)
        rightButton.addTarget(self, action: #selector(didPressSaveButton), for: .touchUpInside)
        
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1568627451, green: 0.4, blue: 0.5254901961, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 19)!]
    }
    
    @objc func didPressedVerifyImage(sender: UITapGestureRecognizer) {
        verifySpotTag = sender.view!.tag
    }
    
    @objc func didPressedAddImage() {
        ImagePickerManager().pickImage(self) { (image) in
            if let image = image {
                self.spotImage.isHidden = true
                self.imageToSave = image
                self.spotImageContainer.backgroundColor = UIColor(patternImage: image)
            } else {
                self.spotImage.isHidden = false
                self.spotImageContainer.backgroundColor = .darkGray
            }
        }
    }
    
    @objc func didPressCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didPressSaveButton() {
        saveNewSpot()
    }
}
