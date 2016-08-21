//
//  Meal.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 5/26/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//  See LICENSE.txt for this sample’s licensing information.
//

import UIKit
import MapKit

import Foundation
import CoreLocation


class Meal  {
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    var longitud : Double
    var latitud : Double
    

    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int ,longitud: Double ,latitud: Double) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        self.longitud = longitud
        self.latitud = latitud
       // super.init()
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }

}