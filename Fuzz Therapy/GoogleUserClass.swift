//
//  googleUserClass.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/15/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import Foundation

class GoogleUser {
    static var sharedInstance = GoogleUser()
    var user:gUser?
}

class gUser {
    var userId:String
    var idToken:String
    var fullName:String
    var givenName:String
    var familyName:String
    var email:String
    
    init(userId:String, idToken:String, fullName:String, givenName:String, familyName:String, email:String) {
        self.userId = userId
        self.idToken = idToken
        self.fullName = fullName
        self.givenName = givenName
        self.familyName = familyName
        self.email = email
    }
}