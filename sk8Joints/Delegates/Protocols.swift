//
//  Protocols.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 11/25/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation



protocol LocationUpdateDelegate {
    func locationDidUpdate(location: CLLocation, address: String)
    func locationError(error: LocationError)
}

protocol UpdateSpotsDelegate {
    func shouldUpdateSpots(isEnableUpdate: Bool)
}
