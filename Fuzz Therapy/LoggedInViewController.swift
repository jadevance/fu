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


  // [START viewdidload]
  override func viewDidLoad() {
    super.viewDidLoad()

    GIDSignIn.sharedInstance().uiDelegate = self
    // Uncomment to automatically sign in the user.
    GIDSignIn.sharedInstance().signInSilently()


    NSNotificationCenter.defaultCenter().addObserver(self,
        selector: #selector(LoggedInViewController.receiveToggleAuthUINotification(_:)),
        name: "ToggleAuthUINotification",
        object: nil)
    statusText.text = "Loading"
    toggleAuthUI()

  }
  // [END viewdidload]

  // [START signout_tapped]
  @IBAction func didTapSignOut(sender: AnyObject) {
    GIDSignIn.sharedInstance().signOut()
    statusText.text = "Signed out."
    toggleAuthUI()
    getUserData()
  }
  // [END signout_tapped]
    
    // [START toggle_auth]
    func toggleAuthUI() {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            // Signed in
            signInButton.hidden = true
            signOutButton.hidden = false
            disconnectButton.hidden = false
        } else {
            signInButton.hidden = false
            signOutButton.hidden = true
            disconnectButton.hidden = true
            statusText.text = "Google Sign in\n"
        }
    }
    // [END toggle_auth]

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

}
