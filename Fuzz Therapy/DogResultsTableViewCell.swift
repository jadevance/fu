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
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}