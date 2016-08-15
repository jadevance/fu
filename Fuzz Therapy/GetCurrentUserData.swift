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
import Google

// this is for getting and posting data with the API, not the oauth login

func getCurrentUserData(completionHandler:(User)->()) {
//    Alamofire.request(.GET, "https://www.fuzztherapy.com/api/").response { (req, res, data, error) -> Void in
//        print(res)
//        let outputString = NSString(data: data!, encoding:NSUTF8StringEncoding)
//        print(outputString)
//    }
    
    let parameters = ["user": "12345"]
    
    Alamofire.request(.POST, "https://www.fuzztherapy.com/api/", parameters: parameters)
        .responseJSON { response in
    
            let userData = JSON(response.result.value!)
            print(userData)
            
            let name = userData[0]["name"].string!
            let uid = userData[0]["uid"].string!
            let location = userData[0]["location"].string!
            let availability = userData[0]["availability"].string!
            let dogName = userData[0]["dog_name"].string!
            let dogBreed = userData[0]["dog_breed"].string!
            let dogAge = userData[0]["dog_age"].int!
            let dogPicture = userData[0]["dog_picture"].string!
            
            let myUser = User(name:name, uid:uid, location:location, availability:availability, dogName:dogName, dogBreed:dogBreed, dogAge:dogAge, dogPicture:dogPicture)
            
            CurrentUser.sharedInstance.user = myUser
            
            completionHandler(myUser)
            
    }
}
