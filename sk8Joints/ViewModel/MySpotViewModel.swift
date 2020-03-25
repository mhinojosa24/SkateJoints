//
//  SpotsViewModel.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 3/17/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import Foundation

final class MySpotViewModel {
    var title: String {
        return "My Spots"
    }
    var spotArr: [Spot] = []
    
    func populateSpots(completionHandler: @escaping () -> Void ) {
        SpotServices.fetchAllSpots { (spots) in
            guard let spots = spots else { return }
            self.spotArr = spots
            completionHandler()
        }
    }
}
