//
//  SpotModal.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/19/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation


struct SpotModal: Codable {
    var id: String?
    var spotName: String?
    var spotImage: String?
    var address: String?
    var spotLat: Double?
    var spotLong: Double?
    var verifySpot: Int?
    
   init(id: String?, spotName: String?, spotImage: String?, address: String?, spotLat: Double?, spotLong: Double?, verifySpot: Int?) {
        self.id = id
        self.spotName = spotName
        self.spotImage = spotImage
        self.address = address
        self.spotLat = spotLat
        self.spotLong = spotLong
        self.verifySpot = verifySpot
    }
    
    func toAnyObject() -> [String: Any] {
        let data = try! JSONEncoder().encode(self)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        return json as! [String : Any]
    }
}


