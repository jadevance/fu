//
//  DogResultsTableViewCell.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/20/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//
import UIKit
import MessageUI

class DogResultsTableViewCell: UITableViewCell, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var dogName: UILabel!
    @IBOutlet weak var availability: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    
    @IBAction func messageButtonPressed(sender: AnyObject) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.messageButton.layer.cornerRadius = 5.0
        self.messageButton.layer.borderWidth = 1.0
        self.messageButton.layer.borderColor = UIColor(red: 0, green: 0.7373, blue: 0.0118, alpha: 1.0).CGColor
        self.messageButton.tintColor = UIColor(red: 0, green: 0.7373, blue: 0.0118, alpha: 1.0)
        self.messageButton.setTitleColor(UIColor(red: 0, green: 0.7373, blue: 0.0118, alpha: 1.0), forState: .Normal)
        self.messageButton.backgroundColor = UIColor(red: 0.7333, green: 0.9765, blue: 0.7373, alpha: 1.0)
        self.dogImage.layer.cornerRadius = 5.0
        self.dogImage.layer.borderColor = UIColor.blackColor().CGColor
        self.dogImage.layer.borderWidth = 2.0
        self.dogImage.clipsToBounds = true

    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}