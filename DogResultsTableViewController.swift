//
//  DogResultsTableViewController.swift
//  Fuzz Therapy
//
//  Created by Jade Vance on 8/20/16.
//  Copyright © 2016 Jade Vance. All rights reserved.
//

import UIKit
import RealmSwift
import MessageUI
import Haneke

class DogResultsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    let realm = try! Realm()
    var results: Results<SearchResults>!
    
    func loadResults() {
        results = try! Realm().objects(SearchResults)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
//         Clears out the Realm Seeds, for dev only
//                    try! realm.write {
//                      realm.deleteAll()
//                    }
        loadResults()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DogResultsTableViewCell"
        
        // Fetches the appropriate result for the data source layout.
        let result = results[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DogResultsTableViewCell
        
        cell.dogName.text = result.dogName
        cell.availability.text = result.availability
        cell.name.text = result.name

        
        if let dogImage = cell.dogImage as? UIImageView {
            if let url = NSURL(string: result.dogPicture!) {
                dogImage.contentMode = UIViewContentMode.ScaleAspectFill
                dogImage.hnk_setImageFromURL(url)
            }
        }
        
        cell.messageButton.tag = indexPath.row
        cell.messageButton.addTarget(self, action: #selector(DogResultsTableViewController.sendEmailButtonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    func sendEmailButtonTapped(sender: UIButton!) {
        // inidcates which realm instance was tapped, integer value from array
        let buttonTag = sender.tag
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["fuzztherapyapp@gmail.com"])
        mailComposerVC.setSubject("Hello from Fuzz Therapy!")
        mailComposerVC.setMessageBody("Hi, I would love to meet your dog! Are you available on...", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (_)in
        })
        
        sendMailErrorAlert.addAction(OKAction)
        self.presentViewController(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    @IBAction func onHomeButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToMenu", sender: self)
    }
}