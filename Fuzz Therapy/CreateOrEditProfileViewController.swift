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
        
        alertResponse()
        
        // compresses and encodes image data into NSData
        
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)



        
        // make an api call to create new account / save details
        
        let gUserId = GoogleUser.sharedInstance.googleUser!.userId
        let name = nameField.text!
        let location = locationField.text!
        let availability = availabilityField.text!
        let dogName = dogNameField.text!
        let dogBreed = dogBreedField.text!
        let dogAge = dogAgeField.text!
        let dogPicture = imageData!
        
        
        let parameters = [
                "uid": "\(gUserId)",
                "name": "\(name)",
                "location": "\(location)",
                "availability": "\(availability)",
                "dog_name": "\(dogName)",
                "dog_breed": "\(dogBreed)",
                "dog_age": "\(dogAge)",
                "dog_picture": "dogPicturePlaceholder"
            ]
        
        Alamofire.request(.POST, "https://www.fuzztherapy.com/api/create/", parameters: parameters)
            .responseJSON { response in }
        
        
        Alamofire.upload(.POST, "https://www.fuzztherapy.com/api/photo/", multipartFormData: { multipartFormData in
            multipartFormData.appendBodyPart(data: imageData!, name: "dog_picture", mimeType: "image/jpeg")
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
                    }
                case .Failure: break
        
                }
            }
        )
  
    }

    func alertResponse() {
        //if successful
        let alertController = UIAlertController(title: "Yay!", message: "Your  profile has been saved.", preferredStyle: .Alert)
    
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        // else unsuccessful
        
        //            let alertController = UIAlertController(title: "Oh no!!", message: "Your profile has NOT been saved.", preferredStyle: .Alert)
        //
        //            let defaultAction = UIAlertAction(title: "Try again?", style: .Default, handler: nil)
        //            alertController.addAction(defaultAction)
        //
        //            presentViewController(alertController, animated: true, completion: nil)
    }
}


