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

class LogInViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpWithEmail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ImplementTwitterLogin()
        ImplementFacebookLogin()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        ImplementFacebookLogin()
        ImplementTwitterLogin()
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
                self.performSegueWithIdentifier("FromLoginToMenuSegue", sender: self)
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
        // loginButton.center = self.view.center
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
            self.performSegueWithIdentifier("FromLoginToMenuSegue", sender: self)
            
        } else {
            print(error.localizedDescription)
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out")
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}