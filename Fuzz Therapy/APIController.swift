//
//  APIController.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/23/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum KeyFields: String {
    case API_AUTH_NAME = "API_AUTH_NAME"
    case API_AUTH_PASSWORD = "API_AUTH_PASSWORD"
}

class APIController {
    var manager: Alamofire.Manager
    let keys: NSDictionary?
    
    required init() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        manager = Alamofire.Manager(configuration: configuration)
        if let path = NSBundle.mainBundle().pathForResource("keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        } else {
            keys = nil
        }
    }
//    let user = "user"
//    let password = "password"
//    
//    Alamofire.request(.GET, "https://httpbin.org/basic-auth/\(user)/\(password)")
//    .authenticate(user: user, password: password)
//    .responseJSON { response in
//    debugPrint(response)
//    }

}
