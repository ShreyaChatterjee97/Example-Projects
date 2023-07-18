//
//  PlaceMarker.swift
//  Map Application
//
//  Created by Shreya Chatterjee on 25/07/22.
//

import UIKit
import GoogleMaps

class PlaceMarker: GMSMarker {
    // 1 : Add a property of type GooglePlace to the PlaceMarker
     let place: GooglePlace
     
     // 2 : Declare a new designated initializer that accepts a GooglePlace as its sole parameter and fully initializes a PlaceMarker with a position, icon image, anchor for the marker’s position and an appearance animation.

     init(place: GooglePlace) {
       self.place = place
       super.init()
       
       position = place.coordinate
       icon = UIImage(named: place.placeType+"_pin")
       groundAnchor = CGPoint(x: 0.5, y: 1)
       appearAnimation = .pop
     }

}
