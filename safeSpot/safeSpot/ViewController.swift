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
    
    var filteredSearch = [Search]()
    var items = [Search]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SEARCH BAR
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        
        // LOCATION MANAGER
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
        let image = UIImage(named: "navbar")
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
                items.append(Search(tag: place![each]!["tags"], name: place![each]!["name"], address: place![each]!["street_address"], zipcode: place![each]!["zipcode"], lat: place![each]!["lat"], long: place![each]!["long"]))
                
                
                let pinLocation = CLLocationCoordinate2DMake(lat,long)
                // Drop a pin
                let dropPin = MKPointAnnotation()
                dropPin.coordinate = pinLocation
                dropPin.title = each
                self.mapView.addAnnotation(dropPin)
            }
        })
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredSearch = items.filter { item in
            return item.name.lowercaseString.containsString(searchText.lowercaseString) || item.address.lowercaseString.containsString(searchText.lowercaseString) || item.tag.lowercaseString.containsString(searchText.lowercaseString) || item.zipcode.lowercaseString.containsString(searchText.lowercaseString)
        }
        
//        tableView.reloadData()
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


extension ViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
