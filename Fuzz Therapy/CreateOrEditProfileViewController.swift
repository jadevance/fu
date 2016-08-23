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
import RealmSwift


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
    @IBOutlet weak var addPhoto: UIButton!
    @IBOutlet weak var photoLibrary: UIButton!
    @IBOutlet weak var saveProfile: UIButton!
    


    override func viewDidLoad() {
        checkValidEntry()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTextFieldDoneEditing(sender: UITextField) {
        checkValidEntry()
        sender.resignFirstResponder()
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
    
    func checkValidEntry() {
        // Disable the Save button if the text field is empty.
        let text1 = nameField.text ?? ""
        let text2 = locationField.text ?? ""
        let text3 = availabilityField.text ?? ""
        let text4 = dogNameField.text ?? ""
        let text5 = dogBreedField.text ?? ""
        let text6 = dogAgeField.text ?? ""
        
        saveProfile.enabled = !text1.isEmpty
        saveProfile.enabled = !text2.isEmpty
        saveProfile.enabled = !text3.isEmpty
        saveProfile.enabled = !text4.isEmpty
        saveProfile.enabled = !text5.isEmpty
        saveProfile.enabled = !text6.isEmpty
    }
    
    @IBAction func onCancelButtonPressed(sender: AnyObject) {
        func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let DestinationVC: LoggedInViewController = segue.destinationViewController as! LoggedInViewController
        }
    }
    

    @IBAction func onSaveButtonPressed(sender: AnyObject) {
        
        // compresses and encodes image data into NSData
        
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)

        // make an api call to create new account / save details locally in a singleton
        
        let gUserId = GoogleUser.sharedInstance.user!.userId
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
        
        
        getSearchResults() { searchResults in

        }
        
        // send the text data
        Alamofire.request(.POST, "http://localhost:3000/api/create/", parameters: parameters)
            .responseJSON { response in }
        
        // send the image data
        Alamofire.upload(.POST, "http://localhost:3000/api/photo/", multipartFormData: { multipartFormData in
            multipartFormData.appendBodyPart(data: "\(gUserId)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"uid")
            multipartFormData.appendBodyPart(data: imageData!, name: "dog_picture", fileName:"DOG.jpg", mimeType: "image/jpeg")
            },
                encodingCompletion: { result in
                    switch result {
                    case .Success(let upload, _, _):
                            upload.progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                        }
                            upload.responseString { response in
                                
                            func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
                                let DestinationVC: DogResultsTableViewController = segue.destinationViewController as! DogResultsTableViewController
                            }
                        }
                    case .Failure: break
                }
            }
        )
    }
}


