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


func getSearchResults(searchTerm:String, completionHandler:(Array<Array<String>>)->()) {
    
    var resultsArray = Array<Array<String>>()
    
    Alamofire.request(.GET, "https://api.spotify.com/v1/search?query=\(searchTerm)&limit=10&type=album")
        .responseJSON { response in
            
            let albumData = JSON(response.result.value!["albums"]!!["items"]!!)
            
            for i in 0...9 {
                
                let name = albumData[i]["name"].string!
                let spotifyUrl = albumData[i]["external_urls"]["spotify"].string!
                let imageUrl = albumData[i]["images"][0]["url"].string!
                
                resultsArray.append([name, spotifyUrl, imageUrl])
                
            }
            
            completionHandler(resultsArray)
            
    }
    
}