//
//  Search.swift
//  safeSpot
//
//  Created by Jessie Albarian on 11/19/16.
//  Copyright © 2016 teamAwesomeSauce. All rights reserved.
//

import Foundation

// Place object
class Search {
    var tag : String
    var name : String
    var address : String
    var zipcode : Int
    var lat : Double
    var long : Double

    init(tag: String, name: String, address: String, zipcode: Int, lat: Double, long: Double) {
        self.tag = tag
        self.name = name
        self.address = address
        self.zipcode = zipcode
        self.lat = lat
        self.long = long
    }
    
}
