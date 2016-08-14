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

func getCurrentUserData(userId: String) {
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
            
            let userName = userData[0]["name"]
            let googleId = userData[0]["uid"]
            let userLocation = userData[0]["location"]
            let userAvailability = userData[0]["availability"]
            let dogName = userData[0]["dog_name"]
            let dogBreed = userData[0]["dog_breed"]
            let dogPicture = userData[0]["dog_picture"]
            
            let myUser = User(id:id, FBid:userFBid, name:userName, picUrl: userPic, msgStat: msgStat)
            CurrentUser.sharedInstance.user = myUser
            
            completionHandler(myUser)
            
    }
}



//                        //API call to migo_rails users#create
//                        
//                        let parameters = [
//                            "user":[
//                                "name":"\(userName)",
//                                "fb_id":"\(userFBid)",
//                                "pic_url":"\(userPic)",
//                                "message_status":msgStat
//                            ]
//                        ]
//                        
//                        Alamofire.request(.POST, "https://www.migo-app.com/users", parameters: parameters)
//                            .responseJSON { response in
//                                
//                                let userData = JSON(response.result.value!)
//                                let id = userData["id"].int!
//                                
//                                let myUser = User(id:id, FBid:userFBid, name:userName, picUrl: userPic, msgStat: msgStat)
//                                CurrentUser.sharedInstance.user = myUser
//                                
//                                completionHandler(myUser)
//                                
//                        }
//                }
//                
//            } else {
//                
//                let userData = JSON(response.result.value![0])
//                let userName = userData["name"].string!
//                
//                print(userData)
//                
//                let id = userData["id"].int!
//                let userFBid = "\(FBSDKAccessToken.currentAccessToken().userID)"
//                let userPic = userData["profile_pic"].string!
//                let msgStat = userData["messages_status"].string!
//                
//                let myUser = User(id:id, FBid:userFBid, name:userName, picUrl: userPic, msgStat: msgStat)
//                
//                CurrentUser.sharedInstance.user = myUser
//                
//                completionHandler(myUser)
//            }
//            
//    }
//    
//}