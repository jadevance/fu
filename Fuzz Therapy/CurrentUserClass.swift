//
//  CurrentUserClass.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/10/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

// Maybe use this as a wrapper / container for SQLite data storage of User info? 
// ask Val about realm

import Foundation

class User {
    var id:Int
    var name:String
    var location:String
    var dogName:String
    
    init(id:Int, name:String, location:String, dogName:String){
        self.id = id
        self.name = name
        self.location = location
        self.dogName = dogName
    }
}