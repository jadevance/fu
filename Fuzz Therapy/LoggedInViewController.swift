import UIKit
import Google

@objc(LoggedInViewController)
class LoggedInViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var createProfileButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    
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

    // can initialize connecting to the API here, if user logged in
    
 
//            // Signed in, has a Fuzz Therapy Account
//        
//            self.userName.text = myUser.name
//            self.editProfileButton.hidden = false
//            self.createProfileButton.hidden = true
//        }
    }

    func toggleAuthUI() {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            
            // Signed in, no Fuzz Therapy account
            signInButton.hidden = true
            signOutButton.hidden = false
            disconnectButton.hidden = false
            self.editProfileButton.hidden = true
            self.createProfileButton.hidden = false


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


