//
//  LogInViewController.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 3/17/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import TwitterKit
import Parse

class LogInViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var LogWithEmail: UIButton!
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var defaults = NSUserDefaults.standardUserDefaults()
    var refreshAlert = UIAlertController(title: "Log out", message: "This action is irriversable. Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
    var errorMessage = "Please try again later"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        ImplementTwitterLogin()
        ImplementFacebookLogin()
        
        
        if defaults.stringForKey("email") != nil{
            emailText.text = defaults.stringForKey("email")
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        ImplementFacebookLogin()
        ImplementTwitterLogin()
        
        if defaults.stringForKey("email") != nil{
            emailText.text = defaults.stringForKey("email")
        }
    }
    
    
    
    // implement Twitter Login
    func ImplementTwitterLogin(){
        let LogInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                    message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.appDelegate.BuildUserInterface()
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                NSLog("Login error: %@", error!.localizedDescription)
            }
        }
        LogInButton.center.x = view.center.x
        LogInButton.center.y = view.center.y+220
        let View = LogInButton.subviews.last! as UIView
        let label = View.subviews.first as! UILabel
        label.text = "       Log in with Twitter              "
        self.view.addSubview(LogInButton)
    }
    
    
    
    // implement Facebook Login
    func ImplementFacebookLogin(){
        if FBSDKAccessToken.currentAccessToken() == nil {
            print("Not logged in")
        } else {
            print("Logged in")
        }
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.frame.size.height = 40
        loginButton.frame.size.width = 280
        loginButton.center.x = view.center.x
        loginButton.center.y = view.center.y+170
        loginButton.delegate = self
        
        self.view.addSubview(loginButton)
    }
    
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error == nil {
            print("Login successful")
            appDelegate.BuildUserInterface()
        } else {
            print(error.localizedDescription)
        }
        
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out")
    }
    
    
    
    func displayError(title: String,_ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func onLogging(sender: AnyObject) {

        let username = emailText.text
        let password = passwordText.text
        
        PFUser.logInWithUsernameInBackground(username!, password: password!) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                if let errorString = error.userInfo["error"] as? String {
                    self.errorMessage = errorString
                    self.displayError("Failed to Sign up", self.errorMessage)
                }
                print(error.localizedDescription)
            } else {
                print("User logged in successfully")
                self.appDelegate.BuildUserInterface()
                // manually segue to logged in view
            }
            
        }
        
        view.endEditing(true)
        }
    
    
    @IBAction func onTap(sender: AnyObject) {
         view.endEditing(true)
    }
    
        
}
    
    
