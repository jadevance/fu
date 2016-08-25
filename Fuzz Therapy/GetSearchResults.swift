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
import RealmSwift

// opening the database connection
let realm = try! Realm()
// instantiating variable up so it can be an instance of realm db
var realm_dogUsers: Results<SearchResults>!


func getSearchResults(completionHandler:(Array<Array<String>>)->()) {
    
    // gets the dog users(doguser.all)
    realm_dogUsers = realm.objects(SearchResults)

    var resultsArray = Array<Array<String>>()

    let enteredLocation = CurrentUser.sharedInstance.user?.location
    let parameters = ["location" : "\(enteredLocation!)"]
    
    Alamofire.request(.POST, "https://www.fuzztherapy.com/api/search", parameters: parameters)
        .responseJSON { response in
            
        let resultsData = JSON(response.result.value!)
            
        for i in 0...15 {
            
            let name = resultsData[i]["name"].string!
            let dogName = resultsData[i]["dog_name"].string!
            let location = resultsData[i]["location"].string!
            let availability = resultsData[i]["availability"].string!
            let dogPicture = resultsData[i]["dog_picture_url"].string!
            let email = resultsData[i]["email"].string!
                
            resultsArray.append([name, dogName, location, availability, dogPicture, email])
            
            // dogUser.New
            let dogUser = SearchResults()
                
            dogUser.name = name
            dogUser.dogName = dogName
            dogUser.location = location
            dogUser.availability = availability
            dogUser.dogPicture = dogPicture
            dogUser.email = email
            
            // dogUser.save
            try! realm.write {
                realm.add(dogUser)
            }
            completionHandler(resultsArray)
        }
    }
}