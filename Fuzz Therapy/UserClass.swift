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
    var dogAge:Int
    var email:String
    
    init(name:String, uid:String, location:String, availability:String, dogName:String, dogBreed:String, dogAge:Int, email:String) {
        
        self.name = name
        self.uid = uid
        self.location = location
        self.availability = availability
        self.dogName = dogName
        self.dogBreed = dogBreed
        self.dogAge = dogAge
        self.email = email 
        
    }
}