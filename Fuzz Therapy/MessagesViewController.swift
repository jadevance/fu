//
//  MessagesViewController.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/22/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onHomeButtonPressed(sender: AnyObject) {
                self.performSegueWithIdentifier("unwindToMenu", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if cellButton === sender {
//        }
        // Pass the selected object to the new view controller.
    }


}
