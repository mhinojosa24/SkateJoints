//
//  SpotMapViewController.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 11/25/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import Kingfisher
import MapKit
import UIKit
import MapboxNavigation


// MARK: - DataSource & Delegate Methods

extension SpotMapViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MySpotCollectionViewCell.cellId, for: indexPath) as! MySpotCollectionViewCell
        cell.navigationLogo.isHidden = true
        let spot = mySpots[indexPath.row % mySpots.count]
        let url = URL(string: spot.spotImage!)
        cell.spotImageView.contentMode = .scaleAspectFill
        cell.spotImageView.kf.indicatorType = .activity
        cell.spotImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.8)), .processor(BlurImageProcessor(blurRadius: 10.0))], progressBlock: nil) { (results) in
            switch results {
            case .success:
                cell.spotTitle.text = spot.spotName
                cell.spotAddressLabel.text = spot.address
                cell.initiateNavigationButton.setBackgroundImage(UIImage(named: "go"), for: .normal)
                switch spot.verifySpot! {
                case 1:
                    let image = UIImage(named: "security")!
                    cell.verifyLogoIndicator.image = image
                    break
                case 2:
                    let image = UIImage(named: "thief")!
                    cell.verifyLogoIndicator.image = image
                    break
                case 3:
                    let image = UIImage(named: "construction")!
                    cell.verifyLogoIndicator.image = image
                    break
                case 4:
                    let image = UIImage(named: "positive")!
                    cell.verifyLogoIndicator.image = image
                    break
                default:
                    let image = UIImage(named: "image")!
                    cell.verifyLogoIndicator.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
        cell.initiateNavigationButton.tag = indexPath.row
        cell.initiateNavigationButton.addTarget(self, action: #selector(didPressedNavigateButton), for: .touchUpInside)
        return cell
    }
}
// MARK: - Delegate Flowlayout Methods
extension SpotMapViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 20
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 27, bottom: 0, right: 27)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: w/2 + 130, height: h/5 - 5)
    }
}

// MARK: - Explicit Instances
extension SpotMapViewController {
    
    func createMap() -> NavigationMapView {
        let map = NavigationMapView(frame: self.view.bounds)
        map.styleURL = MGLStyle.streetsStyleURL
        map.automaticallyAdjustsContentInset = true
        return map
    }
    
    func createCollectionView() -> UICollectionView {
        let layout = SnappingLayout()
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //collectionView.decelerationRate = .init(rawValue: 0.5)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
    
    func createCancelButton() -> Button {
        let button = Button(title: "Cancel", titleColor: #colorLiteral(red: 0.9294117647, green: 0.7058823529, blue: 0.1647058824, alpha: 1), cornerRadius: 0, backgroundColor: .clear, target: self, action: #selector(didPressedCancelButton), event: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        return button
    }
}
// MARK: - Layouts
extension SpotMapViewController {
    
    func layout() {
        view.addSubview(mapView)
        layoutCancelButton()
        layoutCollectionView()
    }
    
    func layoutCancelButton() {
        view.add(subview: cancelButton) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor, constant: 20),
            v.leadingAnchor.constraint(equalTo: p.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            v.heightAnchor.constraint(equalToConstant: 25)
            ]}
    }
    
    func layoutCollectionView() {
        view.add(subview: collectionView) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            v.leadingAnchor.constraint(equalTo: p.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            v.trailingAnchor.constraint(equalTo: p.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            v.heightAnchor.constraint(equalToConstant: p.frame.height/4.5)
        ]}
    }
}
