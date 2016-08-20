import UIKit
import Google

@objc(LoggedInViewController)
class LoggedInViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var createProfileButton: UIButton!
//    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    var viewRefresh = false

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()

        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(LoggedInViewController.receiveToggleAuthUINotification(_:)),
                                                         name: "ToggleAuthUINotification",
                                                         object: nil)
        statusText.text = "Loading"
        toggleAuthUI()
    }

    func toggleAuthUI() {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            
            // Signed in, no Fuzz Therapy account
            signInButton.hidden = true
            signOutButton.hidden = false
            disconnectButton.hidden = true
            self.editProfileButton.hidden = true
            self.createProfileButton.hidden = false
            self.searchButton.hidden = true 


        } else {
            // Not signed in
            createProfileButton.hidden = true
            editProfileButton.hidden = true
            signInButton.hidden = false
            signOutButton.hidden = true
            disconnectButton.hidden = true
            statusText.text = "Sign in with Google\n"
        }
    }

  @IBAction func didTapSignOut(sender: AnyObject) {
    GIDSignIn.sharedInstance().signOut()
    statusText.text = "Signed out."
    toggleAuthUI()
  }



  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self,
        name: "ToggleAuthUINotification",
        object: nil)
  }

  @objc func receiveToggleAuthUINotification(notification: NSNotification) {
    if (notification.name == "ToggleAuthUINotification") {
      self.toggleAuthUI()
      if notification.userInfo != nil {
        let userInfo:Dictionary<String,String!> =
            notification.userInfo as! Dictionary<String,String!>
        self.statusText.text = userInfo["statusText"]
      }
    }
  }
}


