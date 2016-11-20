//
//  ViewController.swift
//  safeSpot
//
//  Created by Susana Gomez-Burgos on 11/18/16.
//  Copyright © 2016 teamAwesomeSauce. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var searchBar: UISearchBar!
    var ref = FIRDatabase.database().reference()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // LOCATION MANAGER STUFF
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        // MAP STUFF
        mapView?.mapType = .Standard
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!), span: span)
        mapView.setRegion(region, animated: true)
        
        // CUSTOM HEADER IMAGE
        searchBar.layer.zPosition = 1
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 70))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "title")
        imageView.image = image
        navBar.titleView = imageView
        
        // CONFIGURE DATABASE
//        ref = FIRDatabase.database().reference()
        
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if !snapshot.exists() { return }
            let keysArray = snapshot.value?.allKeys as! [String]
            
            let place = snapshot.value! as? NSDictionary
            for each in keysArray {
                let lat = place![each]!["lat"] as! Double
                let long = place![each]!["long"] as! Double
                
//                print(place![each]!["lat"])
                
                let pinLocation = CLLocationCoordinate2DMake(lat,long)
                // Drop a pin
                let dropPin = MKPointAnnotation()
                dropPin.coordinate = pinLocation
                dropPin.title = each
                self.mapView.addAnnotation(dropPin)
            }
        })
    }
    
    
    
    // LOCATION MANAGER DELEGATE METHOD
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

