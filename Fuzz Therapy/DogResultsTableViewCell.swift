//
//  DogResultsTableViewCell.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/20/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import UIKit

class DogResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var dogImage: UIImageView!
    
    @IBOutlet weak var dogName: UILabel!
    @IBOutlet weak var availability: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
