//
//  CreateOrEditProfileViewController.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/11/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import Foundation


import UIKit

// Match the ObjC symbol name inside Main.storyboard.
@objc(CreateOrEditViewController)

class CreateOrEditViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var availabilitySelection: UISegmentedControl!
    
    @IBOutlet weak var dogNameField: UITextField!
    @IBOutlet weak var dogBreedField: UITextField!
    @IBOutlet weak var dogAgeField: UITextField!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var saveProfileButton: UIButton!
}