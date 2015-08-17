//
//  ViewController.swift
//  Instagram
//
//  Created by Gray Karegeannes on 4/14/15.
//  Copyright (c) 2015 Gray Karegeannes. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var signupActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //println(PFUser.currentUser())
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil{
            self.performSegueWithIdentifier("login", sender: self)
        }
    }
    
    func displayAlert(title:String, error:String){
        
        var alert = UIAlertController(title: "Something is Wrong", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBOutlet var username: UITextField!
    
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var alreadyRegisteredLabel: UILabel!
    
    @IBOutlet var signupLabel: UILabel!
    
    @IBOutlet var signupButton: UIButton!
    
    @IBOutlet var signupToggleButton: UIButton!
    
    
    @IBAction func toggleSignup(sender: AnyObject) {
        
        if signupActive == true{
            
            signupActive = false
            
            signupLabel.text = "Use the form below to log in."
            
            signupButton.setTitle("Log In", forState: UIControlState.Normal)
            
            alreadyRegisteredLabel.text = "Not Registered?"
            
            signupToggleButton.setTitle("Sign Up", forState: UIControlState.Normal)
        }
        else{
            signupActive = true
            
            signupLabel.text = "Use the form below to sign up."
            
            signupButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            alreadyRegisteredLabel.text = "Already Registered?"
            
            signupToggleButton.setTitle("Log In", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func signup(sender: AnyObject) {
        
        var name:String = username.text
        var pass:String = password.text
        
        var error = ""
        
        if name == "" || pass == "" {
            error = "Please enter a Username and Password"
        
        
        }
        
        if error != "" {
            
            displayAlert("Error in form.", error: error)
            
        }
        
        else{
            var user = PFUser()
            user.username = username.text
            user.password = password.text
            
            self.activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            self.activityIndicator.center = self.view.center
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            self.activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
         
            
            if signupActive == true{
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, signupError: NSError?) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                if signupError == nil {
                    // Hooray! Let them use the app now.
                    self.performSegueWithIdentifier("login", sender: self)
                    
                } else {
                    // Show the errorString somewhere and let the user try again.
                    if let errorString = signupError?.userInfo?["error"] as? NSString {

                    error = errorString as String
                        
                    }
                    else{
                        error = "Please try again later"
                    }
                    self.displayAlert("Could not sign up.", error: error)
                    }
                }
            }
                
        else{
                PFUser.logInWithUsernameInBackground(username.text as String!, password: password.text as String!){
                    (user: PFUser?, signupError: NSError?) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()

                    if signupError == nil{
                        println("Logged In")
                        self.performSegueWithIdentifier("login", sender: self)
                        
                    }
                    else{
                        if let errorString = signupError?.userInfo?["error"] as? NSString {
                            
                            error = errorString as String
                            
                        }
                        else{
                            error = "Please try again later"
                        }
                        self.displayAlert("Could not log in.", error: error)
                    }
                    }
                }
            }
            
        }
        
        
        
    
    
    
    
    

    
    
    
    
    
    
    
    /*var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("Image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        
        pickedImage.image = image
    }
    
    @IBAction func pickImage(sender: AnyObject) {
        
        var image = UIImagePickerController()
        
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    @IBAction func pause(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    @IBAction func restore(sender: AnyObject) {
        
        activityIndicator.stopAnimating()
        //UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    @IBAction func createAlert(sender: AnyObject) {
        
        var alert = UIAlertController(title: "Hello!", message: "Are You Certain of your path?", preferredStyle: UIAlertControllerStyle.Alert)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
    }
    
    
    @IBOutlet var pickedImage: UIImageView!
    
    */
    
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


