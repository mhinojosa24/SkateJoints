//
//  SpotMapViewController.swift
//  SkateJoints
//
//  Created by Student Loaner 3 on 10/17/19.
//  Copyright © 2019 Maximo Hinojosa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Mapbox
import MapboxCoreNavigation
import MapboxDirections
import MapboxNavigation



final class SpotMapViewController: UIViewController, MGLMapViewDelegate {
    
    lazy var mapView: NavigationMapView = self.createMap()
    lazy var cancelButton: Button = self.createCancelButton()
    lazy var collectionView: UICollectionView = self.createCollectionView()
    lazy var mySpots = [Spot]()
    lazy var pins = [MGLPointAnnotation]()
    lazy var h = self.view.frame.height
    lazy var w = self.view.frame.width
    var directionsRoute: Route!
    let regionRadius: CLLocationDistance = 10000
    var currentLocation: CLLocation!
    var directionsArray: [MKDirections] = []
    var numberOfItems: Int = 1000000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSpotMapViewControllerCalls()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(row: numberOfItems / 2, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    private func setUpSpotMapViewControllerCalls() {
        collectionView.register(MySpotCollectionViewCell.self, forCellWithReuseIdentifier: MySpotCollectionViewCell.cellId)
        layout()
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        mapView.delegate = self
        mapView.setUserTrackingMode(.follow, animated: true, completionHandler: nil)
    }
    
    // TODO: clean code
    func calculateRoute(from originCoor: CLLocationCoordinate2D, to destinationCoor: CLLocationCoordinate2D, completion: @escaping (Route?, Error?) -> Void) {
//        guard let annotations = mapView.annotations else { return print("Annotation Error") }
//        if annotations.count != 0 { annotations.forEach { mapView.removeAnnotation($0) }}
//        if pins.count > 0 {
//            mapView.removeAnnotations(mapView.annotations!)
//        }
        mapView.removeOverlays(mapView.overlays)
        let origin = Waypoint(coordinate: originCoor, coordinateAccuracy: -1, name: "Start")
        let destination = Waypoint(coordinate: destinationCoor, coordinateAccuracy: -1, name: "Finish")
        let annotation = MGLPointAnnotation()
        annotation.coordinate = destinationCoor
        annotation.title = "Start Navigation"
        mapView.addAnnotation(annotation)
        pins.append(annotation)
        
        let options = NavigationRouteOptions(waypoints: [origin, destination], profileIdentifier: .automobile)
        
        Directions.shared.calculate(options) { [unowned self] (wayPoints, routes, error) in
            self.directionsRoute = routes?.first
            completion(routes?.first, error)
            self.drawRoute(route: self.directionsRoute!)
            
    
            let coordinateBounds = MGLCoordinateBounds(sw: destinationCoor, ne: originCoor)
            let insets = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
            let routeCam = self.mapView.cameraThatFitsCoordinateBounds(coordinateBounds, edgePadding: insets)
            self.mapView.setCamera(routeCam, animated: true)
        }
    }
    
    /// This function draws a route
    func drawRoute(route: Route) {
        guard route.coordinateCount > 0 else { return }
        var routeCoordinates = route.coordinates!
        let polyline = MGLPolylineFeature(coordinates: &routeCoordinates, count: route.coordinateCount)
        
        if let source = mapView.style?.source(withIdentifier: "route-source") as? MGLShapeSource {
            source.shape = polyline
        } else {
            let source = MGLShapeSource(identifier: "route-source", features: [polyline], options: nil)
            let lineStyle = MGLLineStyleLayer(identifier: "route-style", source: source)
            lineStyle.lineColor = NSExpression(forConstantValue: UIColor.systemBlue)
            lineStyle.lineWidth = NSExpression(forConstantValue: 4.0)
            
            mapView.style?.addSource(source)
            mapView.style?.addLayer(lineStyle)
        }
        
    }
    
    @objc func didPressedCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didPressedNavigateButton(_ sender: Button) {

        mapView.setUserTrackingMode(.none, animated: true, completionHandler: nil)
        let destinationCoor = CLLocationCoordinate2D(latitude: mySpots[sender.tag % mySpots.count].spotLat!, longitude: mySpots[sender.tag % mySpots.count].spotLong!)
        
        calculateRoute(from: mapView.userLocation!.coordinate, to: destinationCoor) { (route, error) in
            
            if error != nil {
                print("Error getting route")
            }
        }
        
        
    }
    
    // Implement the delegate method that allows annotations to show callouts when tapped
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
     
    // Present the navigation view controller when the callout is selected
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        let navigationViewController = NavigationViewController(for: directionsRoute!)
        navigationViewController.modalPresentationStyle = .fullScreen
        self.present(navigationViewController, animated: true, completion: nil)
    }
}
