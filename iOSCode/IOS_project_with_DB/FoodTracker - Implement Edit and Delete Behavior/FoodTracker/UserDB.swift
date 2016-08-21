//
//  UserDB.swift
//  FoodTracker
//
//  Created by Diego Alejandro Orellana Lopez on 8/16/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//


import Foundation
import RealmSwift

class UserDB: Object {
    dynamic var id = ""
    dynamic var email = ""
    dynamic var password = ""
   // dynamic var repeatPassword =
    
    override static func primaryKey() -> String? {
        return "id"
    }


}