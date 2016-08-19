//
//  DogResultsTableViewCell.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/18/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DogResultsTableViewCell: UITableViewCell {


    
    @IBOutlet weak var dogName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
