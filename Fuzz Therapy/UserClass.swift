//
//  UserClass.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/14/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import Foundation
import Google

class CurrentUser {
    static var sharedInstance = CurrentUser()
    var user:User?
}

class User {
    var name:String
    var uid:String
    var location:String
    var availability:String
    var dogName:String
    var dogBreed:String
    var dogAge:Int
    var dogPicture:String
    
    init(name:String, uid:String, location:String, availability:String, dogName:String, dogBreed:String, dogAge:Int, dogPicture:String) {
        
        self.name = name
        self.uid = uid
        self.location = location
        self.availability = availability
        self.dogName = dogName
        self.dogBreed = dogBreed
        self.dogAge = dogAge
        self.dogPicture = dogPicture
        
    }
}

//let userName = userData[0]["name"]
//let googleId = userData[0]["uid"]
//let userLocation = userData[0]["location"]
//let userAvailability = userData[0]["availability"]
//let dogName = userData[0]["dog_name"]
//let dogBreed = userData[0]["dog_breed"]
//let dogPicture = userData[0]["dog_picture"]