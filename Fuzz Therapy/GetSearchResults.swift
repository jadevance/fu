//
//  SearchResultsViewController.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/13/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON


func getSearchResults(completionHandler:(Array<Array<String>>)->()) {
    
    var resultsArray = Array<Array<String>>()
    let enteredLocation = CurrentUser.sharedInstance.user?.location
    let parameters = ["location" : "\(enteredLocation!)"]
    
    Alamofire.request(.POST, "https://www.fuzztherapy.com/api/search", parameters: parameters)
        .responseJSON { response in
            
            let resultsData = JSON(response.result.value!)
            
            for i in 0...9 {
                
                let name = resultsData[i]["name"].string!
                let dogName = resultsData[i]["dog_name"].string!
                let location = resultsData[i]["location"].string!
                let availability = resultsData[i]["availability"].string!
                let dogPicture = resultsData[i]["dog_picture_url"].string!
                
                resultsArray.append([name, dogName, location, availability, dogPicture])
                
            }
            print(resultsArray)
            completionHandler(resultsArray)
    }
}