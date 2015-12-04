//
//  SignUpViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 11/19/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var profileImage: UIImage?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func signUpButtonClicked(sender: AnyObject) {
        signupCheck()
    }
    
    @IBAction func cancelClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToLogin", sender: nil)
    }
    
    @IBAction func selectPictureButtonClicked(sender: AnyObject) {
        var pictureSelector = UIImagePickerController()
        pictureSelector.delegate = self
        pictureSelector.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pictureSelector, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("pickerfunctioncalled")
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.contentMode = .ScaleAspectFit
            profileImageView.image = pickedImage
            profileImage = pickedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signupCheck(){
        if self.passwordTextField.text != self.confirmPasswordTextField.text {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Passwords entered do not match"
            alert.addButtonWithTitle("Try again")
            alert.show()
            self.passwordTextField.text = ""
            self.confirmPasswordTextField.text = ""
            self.passwordTextField.becomeFirstResponder()
        }else if ((self.passwordTextField.text=="") || (self.confirmPasswordTextField.text=="") || (self.usernameTextField.text=="") || (self.emailTextField.text=="")) {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Error: Blank Field"
            alert.addButtonWithTitle("Try again")
            alert.show()
        } else {
            let email = emailTextField.text
            let username = usernameTextField.text
            let password = passwordTextField.text
            let signUpData = PFObject(className: "users")
            if profileImage != nil {
                let imageData = UIImagePNGRepresentation(resizeImage(profileImage!)!)
                let imageFile = PFFile(name: username!+".png", data:imageData!)
                signUpData["profilePicture"] = imageFile
            }
            signUpData["username"] = username
            signUpData["password"] = password
            signUpData["email"] = email
            signUpData["gplay"] = false
            signUpData.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                print(signUpData)
            }
            self.performSegueWithIdentifier("unwindToLogin", sender: nil)
        }
    }
    
    func resizeImage(image: UIImage?) -> UIImage?
    {
        var actualHeight: Float = Float(image!.size.height)
        var actualWidth: Float = Float(image!.size.width)
        let maxHeight: Float = 300.0
        let maxWidth: Float = 400.0
        var imgRatio: Float = actualWidth/actualHeight
        let maxRatio: Float = maxWidth/maxHeight
        let compressionQuality: CGFloat = 0.5
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            } else {
                actualHeight = maxHeight;
                actualWidth = maxWidth;
            }
        }
        let rect = CGRectMake(0.0, 0.0, image!.size.width, image!.size.height)
        UIGraphicsBeginImageContext(rect.size)
        image?.drawInRect(rect)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = UIImageJPEGRepresentation(img, compressionQuality)
        UIGraphicsEndImageContext()
        let resultImage = UIImage(data: imageData!)
        if let resultImage = resultImage {
            return resultImage
        }
        return nil
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == emailTextField{
            self.usernameTextField.becomeFirstResponder()
        }else if textField == usernameTextField{
            self.passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField{
            self.confirmPasswordTextField.becomeFirstResponder()
        }else if textField == confirmPasswordTextField{
            textField.resignFirstResponder()
            signupCheck()
        }
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
