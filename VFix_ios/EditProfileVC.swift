//
//  EditProfileVC.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 3/24/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, UITextFieldDelegate {
    
    var resizedImage:UIImage!
    let imagePicker = UIImagePickerController()
    var image = UIImage()

    
    @IBOutlet weak var CapturedPic: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ToDismissEditVC(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
//    @IBAction func OnSubmit(sender: AnyObject) {
//        print("Submit button clicked")
//        
//        let newImage = resize(image, newSize: CGSize(width: 300, height: 500))
//        InstagramShare.postUserImage(newImage, withCaption: writeCaptionTextField.text) { (success: Bool, error: NSError?) -> Void in
//            
//            if success {
//                self.CapturedPic.image = nil
//                self.writeCaptionTextField.text = nil
//                self.tabBarController?.selectedIndex = 0
//                print("image captured")
//            } else {
//                print("Couldn't post image to database")
//            }
//            
//        }
//        
//    }
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    
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
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
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
    
    

   

}
