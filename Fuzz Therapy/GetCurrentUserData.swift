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

// this is for getting data from the API, not the oauth login

func getCurrentUserData(userId: String) {
    Alamofire.request(.GET, "https://www.fuzztherapy.com/api/").response { (req, res, data, error) -> Void in
        print(res)
        let outputString = NSString(data: data!, encoding:NSUTF8StringEncoding)
        print(outputString)
        print(userId)
    }
}
