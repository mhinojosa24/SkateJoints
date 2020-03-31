//
//  Constant.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 10/20/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//


import Foundation
import Firebase
import FirebaseStorage


/*
    This structure contains constant methods that are called frequently 
 */
struct Constant {
    
    static func setupAlert(alertTitle: String,
                      alertMessage: String,
                      alertStyle: UIAlertController.Style,
                      actionTitle: String,
                      actionStyle: UIAlertAction.Style) -> UIAlertController {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        let action = UIAlertAction(title: actionTitle, style: actionStyle, handler: nil)
        alert.addAction(action)
        return alert
    }
    
    
    
    // MARK: TODO: move database reference to service
    // NOTE: STATIC FUNCTIONS FOR THE DATABASE  
    static func databaseRef() -> DatabaseReference {
        let ref = Database.database().reference().child("Spots")
        return ref
    }
    
    static func storageRef() -> StorageReference {
        let imageIdentifier = NSUUID().uuidString
        let ref = Storage.storage().reference().child("SpotImages").child("\(imageIdentifier).png")
        return ref
    }
    
    
}
