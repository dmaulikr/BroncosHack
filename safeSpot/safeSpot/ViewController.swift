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

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var searchBar: UISearchBar!
    var ref = FIRDatabase.database().reference()
    
    var filteredSearch = [Search]()
    var items = [Search]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    var tableView: UITableView  =   UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // TABLE VIEW
        tableView.frame = CGRectMake(0, 50, 320, 200);
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // SEARCH BAR
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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
            let keysArray = snapshot.value!["places"]!!.allKeys as! [String]
            
            let place = snapshot.value!["places"]! as? NSDictionary
            
            for each in keysArray {
                let tags = place![each]!["tags"] as! String
                let name = place![each]!["name"] as! String
                let address = place![each]!["street_address"] as! String
                let zipcode = place![each]!["zipcode"] as! Int
                let lat = place![each]!["lat"] as! Double
                let long = place![each]!["long"] as! Double
                
                let newPlace = Search(tags: tags, name: name, address: address, zipcode: zipcode, lat: lat, long: long)
                
                self.items.append(newPlace)
                
                
                let pinLocation = CLLocationCoordinate2DMake(lat,long)
                // Drop a pin
                let dropPin = MKPointAnnotation()
                dropPin.coordinate = pinLocation
                dropPin.title = name
                self.mapView.addAnnotation(dropPin)
            }
        })
    }
    
    
    
    // Dismiss keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        
        filteredSearch = items.filter { item in
            
            return item.name.lowercaseString.containsString(searchText.lowercaseString) || item.address.lowercaseString.containsString(searchText.lowercaseString) || item.tags.lowercaseString.containsString(searchText.lowercaseString) || String(item.zipcode).containsString(searchText.lowercaseString)
 
//            return false
        }
        mapView.removeAnnotations(mapView.annotations)
        for item in filteredSearch{
            print(item.name)
            let pinLocation = CLLocationCoordinate2DMake(item.lat,item.long)
                // Drop a pin based on search
                let dropPin = MKPointAnnotation()
                dropPin.coordinate = pinLocation
                dropPin.title = item.name
                self.mapView.addAnnotation(dropPin)
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredSearch.count
        }
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let candy: Search
        if searchController.active && searchController.searchBar.text != "" {
            candy = filteredSearch[indexPath.row]
        } else {
            candy = items[indexPath.row]
        }
        
        
        
        cell.textLabel?.text = candy.name
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}


extension ViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        tableView.layer.zPosition = 1
        self.view.addSubview(tableView)
        
    }
}
