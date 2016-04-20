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
    
    //    var username: String = ""
    //    var password: String = ""
    var checkUser: String?
    //    var checkPass: String = " "
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var defaults = NSUserDefaults.standardUserDefaults()
    var SSSSSSButton = TWTRLogInButton()
    var errorMessage = "Please try again later"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        ImplementTwitterSignUp()
        ImplementFacebookSignUp()
        
        
        //        SSSSSSButton.loginMethods = [.WebBased]
        //
        //        let client = TWTRAPIClient.clientWithCurrentUser()
        //        let request = client.URLRequestWithMethod("GET",
        //                                                  URL: "https://api.twitter.com/1.1/account/verify_credentials.json",
        //                                                  parameters: ["include_email": "true", "skip_status": "true"],
        //                                                  error: nil)
        //        print(request)
        //
        //        client.sendTwitterRequest(request) { response, data, connectionError in }
        //
        
        
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
        
        
        //        var username = emailText.text
        //        var password = passwordText.text
        //        if defaults.stringForKey("email") == nil {
        //            defaults.setObject(username, forKey: "email")
        //        } else {
        //         checkUser = defaults.stringForKey("email")
        //        }
        //   //     checkPass = defaults.stringForKey("password")!
        //        if emailText.text == "" || emailText.text == nil {
        //            var refreshAlert = UIAlertController(title: "Error", message: "Please Insert Email", preferredStyle: UIAlertControllerStyle.Alert)
        //            refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
        //            }))
        //            presentViewController(refreshAlert, animated: true, completion: nil)
        //        } else if username == checkUser {
        //            var refreshAlert = UIAlertController(title: "Error", message: "Username Exist", preferredStyle: UIAlertControllerStyle.Alert)
        //            refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
        //            }))
        //            presentViewController(refreshAlert, animated: true, completion: nil)
        //            print("username exist")
        //        } else if passwordText.text == nil || passwordText.text == "" {
        //            var refreshAlert = UIAlertController(title: "Error", message: "Password Requiered", preferredStyle: UIAlertControllerStyle.Alert)
        //            refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
        //            }))
        //            presentViewController(refreshAlert, animated: true, completion: nil)
        //        } else {
        //            defaults.setObject(username, forKey: "email")
        //            defaults.setObject(password, forKey: "password")
        //            appDelegate.BuildUserInterface()
        //        }
        
        
        
        view.endEditing(true)
        //  self.performSegueWithIdentifier("showNew", sender: self)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                //       var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                self.appDelegate.logUser()
                self.appDelegate.BuildUserInterface()
                // self.performSegueWithIdentifier("showNew", sender: self)
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
        // loginButton.center = self.view.center
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
            //        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.BuildUserInterface()
            //  self.performSegueWithIdentifier("showNew", sender: self)
            
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



