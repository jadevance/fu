//
//  GetCurrentUserData.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/10/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// this is for getting data with the API, not the oauth login

func getCurrentUserData(completionHandler:(User)->()) {
    
    let gUserId = GoogleUser.sharedInstance.user?.userId
    let parameters = ["uid": "\(gUserId)"]
    
    Alamofire.request(.POST, "https://www.fuzztherapy.com/api/", parameters: parameters)
    .responseJSON { response in
        if JSON(response.result.value!)[0] != "user: does not exist" {
            let userData = JSON(response.result.value!)
            print(userData)
            
            let name = userData[0]["name"].string!
            let uid = userData[0]["uid"].string!
            let location = userData[0]["location"].string!
            let availability = userData[0]["availability"].string!
            let dogName = userData[0]["dog_name"].string!
            let dogBreed = userData[0]["dog_breed"].string!
            let dogAge = userData[0]["dog_age"].int!
        
            let myUser = User(name:name, uid:uid, location:location, availability:availability, dogName:dogName, dogBreed:dogBreed, dogAge:dogAge)
            
            CurrentUser.sharedInstance.user = myUser
            completionHandler(myUser)
        }
    }
}