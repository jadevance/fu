//
//  MessagesViewController.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/22/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//



import Foundation
import UIKit


class MessagesViewController: UIViewController {
    
    @IBAction func onHomeButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToMenu", sender: self)
    }
    @IBAction func onBackButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToSearch", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
