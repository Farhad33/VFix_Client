//
//  SettingsViewController.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 3/22/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import MMDrawerController
import Alamofire
import SwiftyJSON


class SettingsViewController: UIViewController {
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate    
    
    @IBOutlet weak var ProfilePicImage: UIImageView!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var AddressTextField: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var StateTextField: UITextField!
    @IBOutlet weak var PostalCodeTextField: UITextField!
    @IBOutlet weak var profileView: UIView!
    

    
    
    
    
    func getClient() {
        firstNameTextField.text! = makeClient.firstName
        lastNameTextField.text! = makeClient.lastName
        emailAddressTextField.text! = makeClient.email
        phoneNumberTextField.text! = makeClient.phone
        AddressTextField.text! = makeClient.street
        CityTextField.text! = makeClient.city
        StateTextField.text! = makeClient.state
        PostalCodeTextField.text! = makeClient.zipCode
    }
    
    
    func setClient() {
        makeClient.firstName = firstNameTextField.text!
        makeClient.lastName = lastNameTextField.text!
        makeClient.email = emailAddressTextField.text!
        makeClient.phone = phoneNumberTextField.text!
        makeClient.street = AddressTextField.text!
        makeClient.city = CityTextField.text!
        makeClient.state = StateTextField.text!
        makeClient.zipCode = PostalCodeTextField.text!
    }
    
    
    @IBAction func onEditing(sender: AnyObject) {
//        rightBarButton.
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getClient()
        
        appDelegate.Design(navigationController!, View: view)
        
        
        if ProfilePicImage.image == nil {
            ProfilePicImage.image = UIImage(named: "missing.png")
        }
        ProfilePicImage.layer.borderWidth = 1
        ProfilePicImage.layer.masksToBounds = false
        ProfilePicImage.layer.borderColor = UIColor.blackColor().CGColor
        ProfilePicImage.layer.cornerRadius = ProfilePicImage.frame.height/2
        ProfilePicImage.clipsToBounds = true
        
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        setClient()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if ProfilePicImage.image == nil {
            ProfilePicImage.image = UIImage(named: "missing.png")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LeftMenuButtonTapped(sender: AnyObject) {
        
        appDelegate.DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
}
