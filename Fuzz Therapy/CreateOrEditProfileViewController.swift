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
    
    
    @IBAction func onTakePhotoPressed(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
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
        self.dismissViewControllerAnimated(true, completion: nil);
    }

    @IBAction func onSaveButtonPressed(sender: AnyObject) {
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        var compressedJPGImage = UIImage(data: imageData!)
//        UIImageWriteToSavedPhotosAlbum(compressedJPGImage, nil, nil, nil)
        // package data
        // fire off callback to API
        // if successful do this:
            let alertController = UIAlertController(title: "Yay!", message: "Your profile has been saved.", preferredStyle: .Alert)
        
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
        
            presentViewController(alertController, animated: true, completion: nil)
        // else if unsuccessful
//            let alertController = UIAlertController(title: "Oh no!!", message: "Your profile has NOT been saved.", preferredStyle: .Alert)
//        
//            let defaultAction = UIAlertAction(title: "Try again?", style: .Default, handler: nil)
//            alertController.addAction(defaultAction)
//        
//            presentViewController(alertController, animated: true, completion: nil)
        
    }
}