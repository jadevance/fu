//
//  CreateOrEditProfileViewController.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/11/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


import UIKit

// Match the ObjC symbol name inside Main.storyboard.
@objc(CreateOrEditViewController)

class CreateOrEditViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var availabilityField: UITextField!
    @IBOutlet weak var dogNameField: UITextField!
    @IBOutlet weak var dogBreedField: UITextField!
    @IBOutlet weak var dogAgeField: UITextField!
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var saveProfile: UIButton!
    @IBOutlet weak var addPhoto: UIButton!
    @IBOutlet weak var photoLibrary: UIButton!

    override func viewDidLoad() {
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTextFieldDoneEditing(sender: UITextField){sender.resignFirstResponder()
    }
    
    @IBAction func onTapGestureRecognized(sender: AnyObject) {
        nameField.resignFirstResponder()
        locationField.resignFirstResponder()
        availabilityField.resignFirstResponder()
        dogNameField.resignFirstResponder()
        dogBreedField.resignFirstResponder()
        dogAgeField.resignFirstResponder()
    }
    
    
    @IBAction func onPhotoLibraryPressed(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imagePicked.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    

    @IBAction func onSaveButtonPressed(sender: AnyObject) {
        
        // compresses and encodes image data into NSData
        
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)

        // make an api call to create new account / save details locally in a singleton
        
        let gUserId = GoogleUser.sharedInstance.googleUser!.userId
        let name = nameField.text!
        let location = locationField.text!
        let availability = availabilityField.text!
        let dogName = dogNameField.text!
        let dogBreed = dogBreedField.text!
        let dogAge:Int? = Int(dogAgeField.text!)
        
        
        let parameters = [
                "uid": "\(gUserId)",
                "name": "\(name)",
                "location": "\(location)",
                "availability": "\(availability)",
                "dog_name": "\(dogName)",
                "dog_breed": "\(dogBreed)",
                "dog_age": "\(dogAge)",
            ]
        
        let myUser = User(name:name, uid:gUserId, location:location, availability:availability, dogName:dogName, dogBreed:dogBreed, dogAge:dogAge!)
        
        CurrentUser.sharedInstance.user = myUser
        
        // send the text data
        Alamofire.request(.POST, "http://localhost:3000/api/create/", parameters: parameters)
            .responseJSON { response in
        
        }
        
        // send the image data
        Alamofire.upload(.POST, "http://localhost:3000/api/photo/", multipartFormData: { multipartFormData in
            multipartFormData.appendBodyPart(data: "\(gUserId)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"uid")
            multipartFormData.appendBodyPart(data: imageData!, name: "dog_picture", fileName:"DOG.jpg", mimeType: "image/jpeg")
        },
            encodingCompletion: { result in
                switch result {
                case .Success(let upload, _, _):
                    upload.progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                        print(totalBytesWritten)
                    }
                    upload.responseString { response in
                        print("Success: \(response.result.isSuccess)")
                        print("Response String: \(response.result.value)")
                        
                        func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
                            let DestinationVC: DogResultsTableViewController = segue.destinationViewController as! DogResultsTableViewController
                        }
//                        self.doTheSearch()
                        getSearchResults() { myArray in
                            print(myArray)
                        }
                        
                    }
                case .Failure: break
                }
            }
        )
    }
    
//    func doTheSearch() {
//        
//        let enteredLocation = self.locationField.text
//        let parameters = ["location" : "\(enteredLocation!)"]
//        
//        Alamofire.request(.POST, "https://www.fuzztherapy.com/api/search", parameters: parameters).responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
//            
//            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
//            }
//        }
//    }
}


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

