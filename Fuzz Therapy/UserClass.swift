//
//  UserClass.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/14/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import Foundation

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
    var dogAge:String
    var dogPic:String
    
    init(userName:String, googleID:String, userLocation:String, userAvailiability:String, dogName:String, dogBreed:String, dogAge:String, dogPicture:String) {
        
        self.name = userName
        self.uid = googleID
        self.location = userLocation
        self.availability = userAvailiability
        self.dogName = dogName
        self.dogBreed = dogBreed
        self.dogAge = dogAge
        self.dogPic = dogPicture
        
    }
}

//let userName = userData[0]["name"]
//let googleId = userData[0]["uid"]
//let userLocation = userData[0]["location"]
//let userAvailability = userData[0]["availability"]
//let dogName = userData[0]["dog_name"]
//let dogBreed = userData[0]["dog_breed"]
//let dogPicture = userData[0]["dog_picture"]