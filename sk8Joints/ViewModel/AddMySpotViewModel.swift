//
//  AddSpotViewModel.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 3/17/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit

final class AddMySpotViewModel {
    var title: String {
        return "Add Spots"
    }
    private var url: URL?
    
    func getImageURL(image: UIImage?) -> URL? {
        if let imageToSave = image {
            SpotServices.saveNewImage(imageToSave) { (url) in
                self.url = url
            }
        }
        return url
    }
    
    func saveSpot(spot: Spot) {
        SpotServices.saveNewSpot(spot, completion: {})
    }
}
