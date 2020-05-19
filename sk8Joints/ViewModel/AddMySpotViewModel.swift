//
//  AddSpotViewModel.swift
//  sk8Joints
//
//  Created by Student Loaner 3 on 3/17/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


enum LocationError {
    case denied
    case restricted
}

protocol LocationUpdateDelegate {
    func locationDidUpdate(location: CLLocation, address: String)
    func locationError(error: LocationError)
}

final class AddMySpotViewModel: NSObject, CLLocationManagerDelegate {
    
    static let sharedModel = AddMySpotViewModel()
    private var locationManager = CLLocationManager()
    private var url: URL?
    var delegate: LocationUpdateDelegate!
    
    var title: String {
        return "Add Spots"
    }
    
    // MARK: - Methods
    
    func getImageURL(image: UIImage?) -> URL? {
        if let imageToSave = image {
            SpotServices.saveNewImage(imageToSave) { (url) in
                self.url = url
            }
        }
        return url
    }
    
    func saveSpot(spot: Spot, completion: @escaping () -> Void) {
        SpotServices.saveNewSpot(spot, completion: {
            //What happens when you are done saving a new spot
            completion()
        })
    }
    
    func validateSpot(_ spotName: String, _ imageName: String, _ tag: Int, completionHandler: @escaping (Bool) -> Void) {
        if spotName.count == 0 || imageName.count == 0 || tag == 0 {
            completionHandler(false)
        } else {
            completionHandler(true)
        }
    }
    
    
    func stopUpdatingLocation() {
        return locationManager.stopUpdatingLocation()
    }
    
    /*
     NOTE: Method returns a formatted adrress string
     */
    private func formatAddress(_ placemark: CLPlacemark?) -> String? {
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
            print("here")
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        // handles getting users address
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in
             
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            guard let placemark = placemarks?.first else {
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
