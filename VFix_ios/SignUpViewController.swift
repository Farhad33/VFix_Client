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


class SignUpViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpWithEmail: UIButton!
    @IBOutlet weak var forgotLabel: UILabel!
    @IBOutlet weak var FacebookLabel: UIButton!
    @IBOutlet weak var TwitterLabel: UIButton!
    
    var username: String = ""
    var password: String = ""
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        ImplementTwitterSignUp()
        ImplementFacebookSignUp()

        
        
    }
    
    @IBAction func onSigningUp(sender: AnyObject) {
        
    //    username = emailText.text!
     //   password = passwordText.text!
    //    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.BuildUserInterface()
      //  self.performSegueWithIdentifier("showNew", sender: self)
        
//        var x = emailText.text
//        userDefaults.set
        
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
                message: "User \(unwrappedSession.userName) has logged in",
                preferredStyle: UIAlertControllerStyle.Alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
     //       var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            self.appDelegate.BuildUserInterface()
            // self.performSegueWithIdentifier("showNew", sender: self)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            NSLog("Login error: %@", error!.localizedDescription)
        }
    }
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
    
    
    
    
    
    
    
}
//    struct TwitterAccount:ReadableSecureStorable, CreateableSecureStorable {
//        let username: String
//        let password: String
//        
//        var account: String { return username }
//        var data: [String: AnyObject] {
//            return ["password": password]
//        }
//    }
//    
//    var account = TwitterAccount(username: "username", password: "password")

    // Save all this to the keychain
   // account.createInSecureStore()
    
    // Now let’s get it back
  //  let result: InternetPasswordSecureStorableResultType = account.readFromSecureStore()
    


