//
//  ResultsClass.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/20/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import Foundation
import RealmSwift

class SearchResults: Object {

    dynamic var name: String? = ""
    dynamic var dogName: String? = ""
    dynamic var location: String? = ""
    dynamic var availability: String? = ""
    dynamic var dogPicture: String? = ""
    
}