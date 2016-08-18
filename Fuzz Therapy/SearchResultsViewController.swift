//
//  SearchResultsViewController.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/13/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import Haneke

class SearchResultsViewController: UITableViewController {
    
    override func viewDidLoad() {
        
        let parameters = ["location" : "Seattle"]
        
        Alamofire.request(.POST, "https://www.fuzztherapy.com/api/search", parameters: parameters)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}