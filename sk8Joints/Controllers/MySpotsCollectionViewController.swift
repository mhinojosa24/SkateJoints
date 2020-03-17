//
//  MySpotsViewController.swift
//  SkateJoints
//
//  Created by Student Loaner 3 on 10/16/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage



class MySpotsCollectionViewController: UICollectionViewController, UpdateSpotsDelegate {
    var spots = [SpotModal](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var dict = [String: String]()
    public var mySpots: ((String?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MySpotCollectionViewCell.self, forCellWithReuseIdentifier: MySpotCollectionViewCell.cellId)
        setUpNavigationUI()
        fetchAllSpots()
        
    }
   
    
    // NOTE: Makes api call and gets all spots created by user
    func fetchAllSpots() {
        SpotServices.fetchAllSpots { (spots) in
            if let spots = spots {
                self.spots = spots
            }
        }
    }
    
    func shouldUpdateSpots(isEnableUpdate: Bool) {
        if isEnableUpdate {
            fetchAllSpots()
        }
    }
    
    @objc func didPressedNavigateBtn(_ sender: UIButton) {
        let spotMapVC = SpotMapViewController()
        spotMapVC.mySpots = spots
        spotMapVC.modalPresentationStyle = .fullScreen
        navigationController?.present(spotMapVC, animated: true, completion: nil)
    }
    
    @objc private func didPressAddSpot() {
        let addMySpotVC = AddMySpotViewController()
        addMySpotVC.delegate = self
        let nav = UINavigationController(rootViewController: addMySpotVC)
        navigationController?.present(nav, animated: true, completion: nil)
    }

    
    private func setUpNavigationUI() {
        navigationController?.navigationBar.topItem?.title = "My Spots"
        let button =  UIButton(type: .custom)
        let addImage = UIImage(named: "add")?.scaled(with: 0.3)
        button.setImage(addImage, for: .normal)
        button.addTarget(self, action: #selector(didPressAddSpot), for: .touchUpInside)
        button.frame = CGRect(x:0, y:0, width: 10, height: 10)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1568627451, green: 0.4, blue: 0.5254901961, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 22)!]
        collectionView.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1803921569, blue: 0.2745098039, alpha: 1)
    }
}



