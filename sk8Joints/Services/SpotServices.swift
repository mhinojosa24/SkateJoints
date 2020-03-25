//
//  NetworkingService.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/20/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
/*
    This class provides networking service
 */
struct SpotServices {
    
    
    static func fetchAllSpots(completion: @escaping ([Spot]?) -> Void) {
        
        let ref = Constant.databaseRef()
        ref.observeSingleEvent(of: .value) { (snapshot) in
            var spots = [Spot]()
            let dg = DispatchGroup()
            
            snapshot.children.forEach { (snap) in
                
                dg.enter()
                guard let snap = snap as? DataSnapshot else { return completion(nil) }
                let value = snap.value
                let spot = try! JSONDecoder().decode(Spot.self, withJSONObject: value!)
                spots.insert(spot, at: 0)
                dg.leave()
            }
            
            dg.notify(queue: .global()) {
                return completion(spots)
            }
        }
    }

    /**
        THIS METHOD CREATES A NEW SPOT AND SENDS IT TO THE DATABASE
        @param spot: the spot to be created on the database
     */
    static func saveNewSpot(_ spot: Spot, completion: @escaping () -> Void) {
        let ref = Constant.databaseRef()
        let spotIdentifier = ref.childByAutoId().key
        ref.child(spotIdentifier!).setValue(spot.toAnyObject())
        completion()
    }
    
    /**
         THIS METHOD SAVES A NEW IMAGE AND RETURNS A URL  WHICH REPRESENTS THAT IMAGE
         @param image: the image to be saved
     */
    static func saveNewImage(_ image: UIImage, completion: @escaping (URL?) -> Void) {
        let ref = Constant.storageRef()
        let imageData = image.pngData()
        
        ref.putData(imageData!, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            ref.downloadURL { (url, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                completion(url!)
            }
        }
    }
    
}
