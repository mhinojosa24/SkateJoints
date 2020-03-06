//
//  MySpotsCollectionViewControllerExt.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/19/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


// MARK: - Delegate Flowlayout Methods
extension MySpotsCollectionViewController: UICollectionViewDelegateFlowLayout {
    // NOTE: spacing for sections
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // NOTE: size for cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 + 165, height: view.frame.height / 2 - 235)
    }
    
    
    // NOTE: insets for sections
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
    }
    
}

// MARK: - DataSource & Delegate Methods
extension MySpotsCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spots.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MySpotCollectionViewCell.cellId, for: indexPath) as! MySpotCollectionViewCell
        
        let spot = spots[indexPath.row]
        let url = URL(string: spot.spotImage!)
        cell.initiateNavigationButton.isHidden = true
        cell.spotImageView.contentMode = .scaleAspectFill
        cell.spotImageView.kf.indicatorType = .activity
        DispatchQueue.main.async {
            cell.spotImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.8)), .processor(BlurImageProcessor(blurRadius: 10.0))], progressBlock: nil) { (results) in
                switch results {
                case .success:
                    cell.spotTitle.text = spot.spotName
                    cell.spotAddressLabel.text = spot.address
                    cell.navigationLogo.setBackgroundImage(UIImage(named: "navigate"), for: .normal)
                    switch spot.verifySpot! {
                    case 1:
                        cell.verifyLogoIndicator.image = verificationImage.security.imageToCell
                        break
                    case 2:
                        cell.verifyLogoIndicator.image = verificationImage.theif.imageToCell
                        break
                    case 3:
                        cell.verifyLogoIndicator.image = verificationImage.construction.imageToCell
                        break
                    case 4:
                        cell.verifyLogoIndicator.image = verificationImage.thumbsUp.imageToCell
                        break
                    default:
                        let image = UIImage(named: "image")!
                        cell.verifyLogoIndicator.image = image
                    }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        cell.navigationLogo.tag = indexPath.row
        cell.navigationLogo.addTarget(self, action: #selector(didPressedNavigateBtn), for: .touchUpInside)
        
        return cell
    }  
}

