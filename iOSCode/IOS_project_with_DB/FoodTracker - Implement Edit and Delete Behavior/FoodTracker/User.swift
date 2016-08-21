
//
//  User.swift
//  FoodTracker
//
//  Created by Diego Alejandro Orellana Lopez on 8/16/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//
import UIKit
import Foundation

class User  {
  
    
    var userEmail: String
   var userPassword: String
    
    // MARK: Initialization
    
    init?(userEmail: String, userPassword: String) {
        // Initialize stored properties.
        self.userEmail = userEmail
        self.userPassword = userPassword
        
        // super.init()
        // Initialization should fail if there is no name or if the rating is negative.
        if userEmail.isEmpty || userPassword.isEmpty  {
            return nil
        }

    }
}
