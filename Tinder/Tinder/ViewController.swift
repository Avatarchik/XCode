//
//  ViewController.swift
//  Tinder
//
//  Created by Gray Karegeannes on 6/9/15.
//  Copyright (c) 2015 Gray Karegeannes. All rights reserved.
//

import UIKit
import Parse
import Bolts
import FBSDKCoreKit

class ViewController: UIViewController {

    @IBOutlet var loginCanceledLabel: UILabel!
    
//    var fbloginView:FBLoginView = FBLoginView(readPermissions: ["email", "public_profile"])
    
    @IBAction func signIn(sender: AnyObject) {
        
        let permissions = ["public_profile"]
        
         self.loginCanceledLabel.alpha = 0
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            
            if let error = error {
                print(error)
            }
            else {
                if let user = user {
                    
                    if let interestedInWomen = user["interestedInWomen"] {
                        
                        self.performSegueWithIdentifier("logUserIn", sender: self)
                    }
                    else {
                        self.performSegueWithIdentifier("signUp", sender: self)
                    }
                    //self.performSegueWithIdentifier("signUp", sender: self)
                }
            }
        
        
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // Uncomment to log the user out upon launching the app
        //PFUser.logOut()
        
        if let username = PFUser.currentUser()?.username {
            if let interestedInWomen = PFUser.currentUser()?["interestedInWomen"] {
                self.performSegueWithIdentifier("logUserIn", sender: self)
            }
            else {
                self.performSegueWithIdentifier("signUp", sender: self)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        
        
//        if PFUser.currentUser() != nil {
//            
//            print("User logged in")
//            print(PFUser.currentUser())
//            
//            if let username = PFUser.currentUser()?.username{
//            
//                performSegueWithIdentifier("logUserIn", sender: self)
//            }
//
//           // print(PFUser.currentUser())
        
        }
        
        
        
//        var push = PFPush()
//        
//        push.setMessage("This is a test")
//        push.sendPushInBackgroundWithBlock { (isSuccessful, error) -> Void in
//            println(isSuccessful)
//        }
//        
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

