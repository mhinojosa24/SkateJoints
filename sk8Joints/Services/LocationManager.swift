//
//  LocationService.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 11/22/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


enum LocationError {
    case denied
    case restricted
}


class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedManager = LocationManager()
    private var locationManager = CLLocationManager()
    var delegate: LocationUpdateDelegate!
    
    // MARK: - init
    
    override init() {
        super.init()
    }
    
    // MARK: - Methods
    
    func stopUpdatingLocation() {
        return locationManager.stopUpdatingLocation()
    }
    
    /*
     NOTE: Method returns a formatted adrress string
     */
    func formatAddress(_ placemark: CLPlacemark?) -> String? {
        guard
            let streetNumber = placemark?.subThoroughfare,
            let streetName = placemark?.thoroughfare,
            let city = placemark?.locality,
            let state = placemark?.administrativeArea,
            let zipcode = placemark?.postalCode
            else { return "" }
            
        return "\(streetNumber) \(streetName) \(city), \(state) \(zipcode)"
    }
    
    /*
     NOTE: Method detects when location services is enabled
     */
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
            self.checkLocationAuthorization()
        } else {
            self.delegate.locationError(error: .denied)
        }
    }
    
    /*
     NOTE: Method evaluates the authorization status for user location
    */
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        case .denied:
           // show alert instructing the how to turn on permissions
            self.delegate.locationError(error: .denied)
        case .restricted:
            self.delegate.locationError(error: .restricted)
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            break
        @unknown default:
           fatalError()
        }
    }
       
    
    /*
     NOTE: Method shows an alert view for bad requests when accessing user location
    */
//    func showLocationDisablePopUp() {
//        let alert = UIAlertController(title: "Background Location Access Disabled", message: "In order to save gnarly spots we need your location.", preferredStyle: .alert)
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
//
//            if let url = URL(string: UIApplication.openSettingsURLString) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
////            }
//        }
//        alert.addAction(cancel)
//        alert.addAction(openAction)
//    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        // handles getting users address
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)-> Void in
             
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            guard let placemark = placemarks?.first else {
//                let alert = Constant.setupAlert(alertTitle: "Geocoder", alertMessage: "Problem with the data received from geocoder", alertStyle: .alert, actionTitle: "OK", actionStyle: .cancel)
                
                print("Problem with the data received from geocoder")
                return
            }
            guard let address = self.formatAddress(placemark) else { return }
            DispatchQueue.main.async {
                self.delegate.locationDidUpdate(location: location, address: address)
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.checkLocationAuthorization()
    }
}
