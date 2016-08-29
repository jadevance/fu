import UIKit
import Google

@objc(LoggedInViewController)
class LoggedInViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var createProfileButton: UIButton!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()

        NSNotificationCenter.defaultCenter().addObserver(self,
        selector: #selector(LoggedInViewController.receiveToggleAuthUINotification(_:)),
        name: "ToggleAuthUINotification",
        object: nil)
        
        toggleAuthUI()
        statusText.text = ""
    }

    func toggleAuthUI() {
       
        getCurrentUserData(){ myUser in
            if (GIDSignIn.sharedInstance().hasAuthInKeychain() && CurrentUser.sharedInstance.user?.name != "placeholder"){
                // Signed in, no Fuzz Therapy account
                self.signInButton.hidden = true
                self.signOutButton.hidden = false
                self.disconnectButton.hidden = true
                self.editProfileButton.hidden = true
                self.createProfileButton.hidden = false
                self.searchButton.hidden = true
            } else if (GIDSignIn.sharedInstance().hasAuthInKeychain() && CurrentUser.sharedInstance.user?.name == "placeholder") {
                // Signed in, has a Fuzz Therapy account
                self.signInButton.hidden = true
                self.signOutButton.hidden = false
                self.disconnectButton.hidden = true
                self.editProfileButton.hidden = false
                self.createProfileButton.hidden = true
                self.searchButton.hidden = false 
            } else {
                // Not signed in
                self.createProfileButton.hidden = true
                self.editProfileButton.hidden = true
                self.searchButton.hidden = true
                self.signInButton.hidden = false
                self.signOutButton.hidden = true
                self.disconnectButton.hidden = true
                self.statusText.text = "Sign in with Google"
        }
    }
}

    @IBAction func didTapSignOut(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        toggleAuthUI()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,
        name: "ToggleAuthUINotification",
        object: nil)
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}

// part of the Google oauth bridging from Objective C

    @objc func receiveToggleAuthUINotification(notification: NSNotification) {
        if (notification.name == "ToggleAuthUINotification") {
            self.toggleAuthUI()
            if notification.userInfo != nil {
                let userInfo:Dictionary<String,String!> = notification.userInfo as! Dictionary<String,String!>
                self.statusText.text = userInfo["statusText"]
                }
            }
        }
    }


