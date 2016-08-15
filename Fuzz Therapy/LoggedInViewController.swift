import UIKit

// Match the ObjC symbol name inside Main.storyboard.
@objc(LoggedInViewController)
// [START viewcontroller_interfaces]
class LoggedInViewController: UIViewController, GIDSignInUIDelegate {
// [END viewcontroller_interfaces]

    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var createProfileButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var editProfileButton: MyCustomButton!
    
    

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
    getCurrentUserData { myUser in
        self.userName.text = myUser.name
    }

  }
    
    
// [START toggle_auth]
    func toggleAuthUI() {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            // Signed in
            signInButton.hidden = true
            signOutButton.hidden = false
            disconnectButton.hidden = false
            // if has profile with Fuzz Therapy
            // editProfileButton.hidden = true
            // createProfileButton.hidden = false
            // else edit is false and create is true
            editProfileButton.hidden = false
            createProfileButton.hidden = false

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
    // [END toggle_auth]
  // [START signout_tapped]
  @IBAction func didTapSignOut(sender: AnyObject) {
    GIDSignIn.sharedInstance().signOut()
    statusText.text = "Signed out."
    toggleAuthUI()
  }
  // [END signout_tapped]

  // [START disconnect_tapped]
  @IBAction func didTapDisconnect(sender: AnyObject) {
    GIDSignIn.sharedInstance().disconnect()
    // [START_EXCLUDE silent]
    statusText.text = "Disconnecting."
    // [END_EXCLUDE]
  }
  // [END disconnect_tapped]


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
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        <#code#>
//    }

}
