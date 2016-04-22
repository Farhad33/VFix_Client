//
//  EditProfileVC.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 3/24/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, UITextFieldDelegate {
    
    
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var resizedImage:UIImage!
    let imagePicker = UIImagePickerController()
    var image = UIImage()
    var defaults = NSUserDefaults.standardUserDefaults()
    static var ProfileImg = "PROFILE_IMAGE"

    
    
    
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var CapturedPic: UIImageView!
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PhoneNumTextField: UITextField!
    @IBOutlet weak var AddressLineOneTextField: UITextField!
    @IBOutlet weak var AddressLineTwoTextField: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var StateTextField: UITextField!
    @IBOutlet weak var PostalCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        appDelegate.Design(navigationController!, View: view)
        
        
        FirstNameTextField.text = defaults.stringForKey("firstName")
        LastNameTextField.text = defaults.stringForKey("lastName")
        EmailTextField.text = defaults.stringForKey("email")
        PhoneNumTextField.text = defaults.stringForKey("phoneNumber")
        AddressLineOneTextField.text = defaults.stringForKey("addressLine1")
        AddressLineTwoTextField.text = defaults.stringForKey("addressLine2")
        CityTextField.text = defaults.stringForKey("city")
        StateTextField.text = defaults.stringForKey("state")
        PostalCodeTextField.text = defaults.stringForKey("postalCode")
        
        if CapturedPic.image == nil {
            CapturedPic.image = UIImage(named: "missing.png")
        } else {
        if let imgData = defaults.objectForKey("image") as? NSData
        {
            if let image = UIImage(data: imgData)
            {
                self.CapturedPic.image = image
         //       defaults.removeObjectForKey("image")
            }
        }
        }
        CapturedPic.layer.borderWidth = 1
        CapturedPic.layer.masksToBounds = false
        CapturedPic.layer.borderColor = UIColor.blackColor().CGColor
        CapturedPic.layer.cornerRadius = CapturedPic.frame.height/2
        CapturedPic.clipsToBounds = true
    }
    
    
    
    
    
    override func viewWillDisappear(animated: Bool)
    {
        let FirstName = FirstNameTextField.text
        let LastName = LastNameTextField.text
        let Email = EmailTextField.text
        let PhoneNumber = PhoneNumTextField.text
        let AddressLine1 = AddressLineOneTextField.text
        let AddressLine2 = AddressLineTwoTextField.text
        let City = CityTextField.text
        let State = StateTextField.text
        let PostalCode = PostalCodeTextField.text
//        let ProfileJPEG: UIImage = CapturedPic.image!
//        let ProfileJPG = UIImageJPEGRepresentation(ProfileJPEG, 1)! as NSData
        
        defaults.setObject(FirstName, forKey: "ffirstName")
        defaults.setObject(LastName, forKey: "llastName")
        defaults.setObject(Email, forKey: "eemail")
        defaults.setObject(PhoneNumber, forKey: "pphoneNumber")
        defaults.setObject(AddressLine1, forKey: "aaddressLine1")
        defaults.setObject(AddressLine2, forKey: "aaddressLine2")
        defaults.setObject(City, forKey: "ccity")
        defaults.setObject(State, forKey: "sstate")
        defaults.setObject(PostalCode, forKey: "ppostalCode")
      //  defaults.setObject(ProfileJPG, forKey: "image")
        
        userDefaults.synchronize()
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        FirstNameTextField.text = defaults.stringForKey("ffirstName")
        LastNameTextField.text = defaults.stringForKey("llastName")
        EmailTextField.text = defaults.stringForKey("email")
        PhoneNumTextField.text = defaults.stringForKey("pphoneNumber")
        AddressLineOneTextField.text = defaults.stringForKey("aaddressLine1")
        AddressLineTwoTextField.text = defaults.stringForKey("aaddressLine2")
        CityTextField.text = defaults.stringForKey("ccity")
        StateTextField.text = defaults.stringForKey("sstate")
        PostalCodeTextField.text = defaults.stringForKey("ppostalCode")
        
        if CapturedPic.image == nil {
            CapturedPic.image = UIImage(named: "missing.png")
        } else {
        if let imgData = defaults.objectForKey("image") as? NSData
        {
            if let image = UIImage(data: imgData)
            {
                self.CapturedPic.image = image
            //    defaults.removeObjectForKey("image")
            }
        }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ToDismissEditVC(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func TakeNewImage(sender: AnyObject) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        print("Image picker vc displayed")
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func AddExistingImage(sender: AnyObject) {
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func saveToCamera(image: UIImage?) {
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
                defaults.removeObjectForKey("image")
            }
                image = originalImage
            
            saveToCamera(image)
            dismissViewControllerAnimated(true, completion: nil)
            self.CapturedPic.image = image
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @IBAction func ChangePicture(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5, animations: {
        self.View1.center.y = self.view.bounds.height / 1.12            })
        view.endEditing(true)
        
    }
    
    
    @IBAction func OnSave(sender: AnyObject) {
        let FirstName = FirstNameTextField.text
        let LastName = LastNameTextField.text
        let Email = EmailTextField.text
        let PhoneNumber = PhoneNumTextField.text
        let AddressLine1 = AddressLineOneTextField.text
        let AddressLine2 = AddressLineTwoTextField.text
        let City = CityTextField.text
        let State = StateTextField.text
        let PostalCode = PostalCodeTextField.text
        let ProfileJPEG: UIImage = CapturedPic.image!
        let ProfileJPG = UIImageJPEGRepresentation(ProfileJPEG, 1)! as NSData
        
        defaults.setObject(FirstName, forKey: "firstName")
        defaults.setObject(LastName, forKey: "lastName")
        defaults.setObject(Email, forKey: "email")
        defaults.setObject(PhoneNumber, forKey: "phoneNumber")
        defaults.setObject(AddressLine1, forKey: "addressLine1")
        defaults.setObject(AddressLine2, forKey: "addressLine2")
        defaults.setObject(City, forKey: "city")
        defaults.setObject(State, forKey: "state")
        defaults.setObject(PostalCode, forKey: "postalCode")
        defaults.setObject(ProfileJPG, forKey: "image")
        
        let check5 = false
        defaults.setBool(check5, forKey: "BoooL")
        userDefaults.synchronize()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        UIView.animateWithDuration(0, animations: {
            self.View1.center.y = self.view.bounds.height / 0})
        
    }

   

}
