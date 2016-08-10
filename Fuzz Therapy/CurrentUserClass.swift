//
//  CurrentUserClass.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/10/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import Foundation

class CurrentUser {
    static var sharedInstance = CurrentUser()
    var user:User?
}

class User {
    var id:Int
    var FBid:String
    var name:String
    var profile_url:String
    var messageStatus:String
    
    var myActivites: Dictionary<Int, Array<String>> = [:]
    var friendActivites: Dictionary<Int, Array<String>> = [:]
    
    var fbFriends: Dictionary<String, String> = [:]
    var friendStatus: Dictionary<String, String> = [:]
    
    var messages: Dictionary<String, String> = [:]
    
    init(id:Int, FBid:String, name:String, picUrl:String, msgStat:String){
        self.id = id
        self.FBid = FBid
        self.name = name
        self.profile_url = picUrl
        self.messageStatus = msgStat
        
    }
}

// Perform any operations on signed in user here.
//let userId = user.userID                  // For client-side use only!
//let idToken = user.authentication.idToken // Safe to send to the server
//let idTokenExpiration = user.authentication.idTokenExpirationDate 
//let fullName = user.profile.name
//let givenName = user.profile.givenName
//let familyName = user.profile.familyName
//let email = user.profile.email