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
    var tags : String
    var name : String
    var address : String
    var zipcode : Int
    var lat : Double
    var long : Double

    init() {
        self.tags = ""
        self.name = ""
        self.address = ""
        self.zipcode = 0
        self.lat = 0.0
        self.long = 0.0
    }
    
    init(tags: String, name: String, address: String, zipcode: Int, lat: Double, long: Double) {
        self.tags = tags
        self.name = name
        self.address = address
        self.zipcode = zipcode
        self.lat = lat
        self.long = long
    }
    
}
