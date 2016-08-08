//
//  UserObject.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/7/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

// wrapper for response from API 

import Foundation
import SwiftyJSON

class UserObject {
    var pictureURL: String!
    var username: String!
    
    required init(json: JSON) {
        pictureURL = json["picture"]["medium"].stringValue
        username = json["email"].stringValue
    }
}