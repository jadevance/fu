//
//  CurrentUserClass.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/10/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

// Maybe use this as a wrapper / container for SQLite data storage of User info

import Foundation

class CurrentUser {
    static var sharedInstance = CurrentUser()
    var user:User?
}

class User {
    // Perform any operations on signed in user here.
    //let userId = user.userID
    //let idToken = user.authentication.idToken
    //let idTokenExpiration = user.authentication.idTokenExpirationDate
    //let fullName = user.profile.name
    //let givenName = user.profile.givenName
    //let familyName = user.profile.familyName
    //let email = user.profile.email
    
//    
//    }
}
