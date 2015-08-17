//
//  SignupViewController.swift
//  Tinder
//
//  Created by Gray Karegeannes on 7/7/15.
//  Copyright (c) 2015 Gray Karegeannes. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {

    @IBOutlet var profilePic: UIImageView!
    
    @IBOutlet var genderSwitch: UISwitch!
    
    @IBAction func signUp(sender: AnyObject) {
        
        PFUser.currentUser()?["interestedInWomen"] = genderSwitch.on
        PFUser.currentUser()?.save()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender"])

        graphRequest.startWithCompletionHandler({
            (connection, result, error) -> Void in
            
            if error != nil{
                print(error)
            }
            else if let result = result {
                print(result)
                
                //Save facebook account info to Parse
                
                PFUser.currentUser()?["gender"] = result["gender"]
                PFUser.currentUser()?["name"] = result["name"]
                
                let userId = result["id"] as! String
                
                let facebookProfilePictureURL = "https://graph.facebook.com/" + userId + "/picture?type=large"
                if let fbpicUrl = NSURL(string: facebookProfilePictureURL) {
                    if let data = NSData(contentsOfURL: fbpicUrl){
                        self.profilePic.image = UIImage(data: data)
                        let imageFile:PFFile = PFFile(data: data)
                        
                        PFUser.currentUser()?["image"] = imageFile
                        
                        PFUser.currentUser()?.save()
                    }
                    
                }
                
                
                
                
                
            }
        })
        
        
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
