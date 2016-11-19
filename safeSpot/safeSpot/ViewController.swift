//
//  ViewController.swift
//  safeSpot
//
//  Created by Susana Gomez-Burgos on 11/18/16.
//  Copyright © 2016 teamAwesomeSauce. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView?.mapType = .Standard
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.7326808, longitude: -73.9843407), span: span)
        mapView.setRegion(region, animated: true)
//        let nyc = CLLocationCoordinate2D(latitude: 40.7326808, longitude: -73.9843407)
//        mapView?.setCenterCoordinate(nyc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

