//
//  PostCurrentUserData.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/11/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Google

func postCurrentUserData(userId: String) {

let parameters = ["uid": "28748758",
                  "name": "Jade",
                  "location": "Seattle",
                  "availability": "every day",
                  "dog_name": "Harley",
                  "dog_breed": "cattle dog husky mix",
                  "dog_picture": "http://i.imgur.com/k1yVI.jpg"]

Alamofire.request(.POST, "https://www.fuzztherapy.com/api/create", parameters: parameters).response { (req, res, data, error) -> Void in
    print(res)
    let outputString = NSString(data: data!, encoding:NSUTF8StringEncoding)
    print(outputString)
    }
}

