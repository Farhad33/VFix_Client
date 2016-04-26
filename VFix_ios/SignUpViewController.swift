//
//  SignUpViewController.swift
//  VFix_ios
//
//  Created by Majid Rahimi on 2/25/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import TwitterKit
import Fabric
import Crashlytics
import Parse


class SignUpViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpWithEmail: UIButton!
    @IBOutlet weak var forgotLabel: UILabel!
    @IBOutlet weak var FacebookLabel: UIButton!
    @IBOutlet weak var TwitterLabel: UIButton!
    
    var checkUser: String?
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var defaults = NSUserDefaults.standardUserDefaults()
    var SSSSSSButton = TWTRLogInButton()
    var errorMessage = "Please try again later"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        ImplementTwitterSignUp()
        ImplementFacebookSignUp()
        
        if defaults.stringForKey("email") != nil{
            emailText.text = defaults.stringForKey("email")
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        if defaults.stringForKey("email") != nil{
            emailText.text = defaults.stringForKey("email")
        }
    }
    
    
    func displayError(title: String,_ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func onSigningUp(sender: AnyObject) {
        
        let newUser = PFUser()
        
        // set user properties
        newUser.username = emailText.text
        newUser.email = emailText.text
        newUser.password = passwordText.text
        
        // call sign up function on the object
        if emailText.text == "" {
            displayError("Error", "The email field is empty")
        } else if passwordText.text == "" {
            displayError("Error", "The password field is empty")
        } else {
            newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if let error = error {
                    if let errorString = error.userInfo["error"] as? String {
                        self.errorMessage = errorString
                        self.displayError("Failed to Sign up", self.errorMessage)
                    }
                    print(error.localizedDescription)
                } else {
                    print("User Registered successfully")
                    self.appDelegate.BuildUserInterface()
                    // manually segue to logged in view
                }
            }
        }
        
       view.endEditing(true)
      //  self.performSegueWithIdentifier("showNew", sender: self)
    }

    
    
    
    // implement Twitter Sign Up
    func ImplementTwitterSignUp(){
    let TwSignUpButton = TWTRLogInButton { (session, error) in
        if let unwrappedSession = session {
            let alert = UIAlertController(title: "Logged In",
                message: "User \(unwrappedSession.userName) has logged in ",
                preferredStyle: UIAlertControllerStyle.Alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.appDelegate.logUser()
            self.appDelegate.BuildUserInterface()
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            NSLog("Login error: %@", error!.localizedDescription)
        }
    
        
        
        
    }
        SSSSSSButton = TwSignUpButton
        
        

    TwSignUpButton.center.x = view.center.x
    TwSignUpButton.center.y = view.center.y+220
    let View = TwSignUpButton.subviews.last! as UIView
    let label = View.subviews.first as! UILabel
    label.text = "       Sign Up with Twitter            "
    self.view.addSubview(TwSignUpButton)
    }
    
    
    // implement Facebook Sign Up
    func ImplementFacebookSignUp(){
        if FBSDKAccessToken.currentAccessToken() == nil {
            print("Not logged in")
        } else {
            print("Logged in")
        }
    
        let FbSignUpButton = FBSDKLoginButton()
        FbSignUpButton.readPermissions = ["public_profile", "email", "user_friends"]

        FbSignUpButton.frame.size.height = 40
        FbSignUpButton.frame.size.width = 280
        FbSignUpButton.center.x = view.center.x
        FbSignUpButton.center.y = view.center.y+170
        FbSignUpButton.delegate = self
        
        let titleText = NSAttributedString(string: "Sign Up with Facebook")
        FbSignUpButton.setAttributedTitle(titleText, forState: UIControlState.Normal)
    
        self.view.addSubview(FbSignUpButton)
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
    
    
    @IBAction func onTap(sender: AnyObject) {
         view.endEditing(true)
    }
    
    
    
    
    
}
    


