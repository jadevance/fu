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
    @IBOutlet weak var cancel: UIButton!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveProfile.enabled = false
        
        // this is so gross but idk
        self.addPhoto.layer.cornerRadius = 5.0;
        self.addPhoto.layer.borderColor = UIColor.blackColor().CGColor
        self.addPhoto.layer.borderWidth = 1.0
        self.addPhoto.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
        
        self.photoLibrary.layer.cornerRadius = 5.0;
        self.photoLibrary.layer.borderColor = UIColor.blackColor().CGColor
        self.photoLibrary.layer.borderWidth = 1.0
        self.photoLibrary.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
        
        self.saveProfile.layer.cornerRadius = 5.0;
        self.saveProfile.tintColor = UIColor.lightGrayColor()
        self.saveProfile.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.saveProfile.layer.borderWidth = 1.0
        self.saveProfile.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
        
        self.cancel.layer.cornerRadius = 5.0;
        self.cancel.layer.borderColor = UIColor.blackColor().CGColor
        self.cancel.layer.borderWidth = 1.0
        self.cancel.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func onTextFieldEditingChanged(sender: AnyObject) {
        let input1 = checkTextInput(nameField.text!)
        let input2 = checkTextInput(locationField.text!)
        let input3 = checkTextInput(availabilityField.text!)
        let input4 = checkTextInput(dogNameField.text!)
        let input5 = checkTextInput(dogBreedField.text!)
        let input6 = checkTextInput(dogAgeField.text!)
        
        if (input1 && input2 && input3 && input4 && input5 && input6) == true {
            // true
            saveProfile.enabled = true
            self.saveProfile.layer.borderColor = UIColor(red: 0, green: 0.7373, blue: 0.0118, alpha: 1.0).CGColor
            self.saveProfile.tintColor = UIColor(red: 0, green: 0.7373, blue: 0.0118, alpha: 1.0)
            self.saveProfile.setTitleColor(UIColor(red: 0, green: 0.7373, blue: 0.0118, alpha: 1.0), forState: .Normal)
            self.saveProfile.backgroundColor = UIColor(red: 0.7333, green: 0.9765, blue: 0.7373, alpha: 1.0)
        } else {
            // false
            saveProfile.enabled = false
            self.saveProfile.tintColor = UIColor.lightGrayColor()
            self.saveProfile.layer.borderColor = UIColor.lightGrayColor().CGColor
            self.saveProfile.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            self.saveProfile.backgroundColor = UIColor(red: 0 , green: 0, blue: 0, alpha: 0)
        }
    }
    
    func checkTextInput(text: String) -> Bool {
        var result = false
        if text != "" {
            result = true
        }
        return result
    }
    
    @IBAction func onTextFieldDoneEditing(sender: UITextField) {
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
    
    @IBAction func onCameraButtonPressed(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
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
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func onCancelButtonPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Action Cancelled!", message: "Profile not saved", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (_)in
            self.performSegueWithIdentifier("unwindToMenu", sender: self)
        })
        alert.addAction(OKAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func onSaveButtonPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Success!", message: "Profile Saved!!", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (_)in
            self.performSegueWithIdentifier("ShowResults", sender: self)
        })
        alert.addAction(OKAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
        // compresses and encodes image data into NSData
        
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)

        // make an api call to create new account / save details locally in a singleton
        
        let gUserId = GoogleUser.sharedInstance.user!.userId
        let name = nameField.text!
        let location = locationField.text!
        let availability = availabilityField.text!
        let dogName = dogNameField.text!
        let dogBreed = dogBreedField.text!
        let dogAge:Int? = Int(dogAgeField.text!)
        let email = GoogleUser.sharedInstance.user!.email
        
        
        let parameters = [
                "uid": "\(gUserId)",
                "name": "\(name)",
                "location": "\(location)",
                "availability": "\(availability)",
                "dog_name": "\(dogName)",
                "dog_breed": "\(dogBreed)",
                "dog_age": "\(dogAge)",
                "email": "\(email)"
            ]
        
        let myUser = User(name:name, uid:gUserId, location:location, availability:availability, dogName:dogName, dogBreed:dogBreed, dogAge:dogAge!, email:email)
        
        CurrentUser.sharedInstance.user = myUser
        
        getSearchResults() { searchResults in }
        
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
                        }
                    case .Failure: break
                }
            }
        )
    }
}


