//
//  CustomSearchBar.swift
//  safeSpot
//
//  Created by Jessie Albarian on 11/20/16.
//  Copyright © 2016 teamAwesomeSauce. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = frame
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func indexOfSearchFieldInSubviews() -> Int! {
        var index: Int!
        let searchBarView = subviews[0] 
        
        for i in 0 ..< searchBarView.subviews.count {
            if searchBarView.subviews[i].isKindOfClass(UITextField) {
                index = i
                break
            }
        }
        
        return index
    }

    override func drawRect(rect: CGRect) {
        // Find the index of the search field in the search bar subviews.
        if let index = indexOfSearchFieldInSubviews() {
            // Access the search field
            let searchField: UITextField = (subviews[0] ).subviews[index] as! UITextField
            
            // Set its frame.
            searchField.frame = CGRectMake(5.0, 5.0, frame.size.width - 10.0, frame.size.height - 10.0)
            
            // Set the background color of the search field.
            searchField.backgroundColor = barTintColor
        }
        
        super.drawRect(rect)
    }
}
