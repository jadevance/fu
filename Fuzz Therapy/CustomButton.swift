//
//  CustomButton.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/13/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import Foundation
import UIKit

class MyCustomButton: UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1.0
        self.tintColor = UIColor.whiteColor()
        self.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
    }
}
