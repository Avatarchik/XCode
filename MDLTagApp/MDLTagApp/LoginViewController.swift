//
//  LoginViewController.swift
//  MDLTagApp
//
//  Created by Gray Karegeannes on 8/4/15.
//  Copyright © 2015 Gray Karegeannes. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    
    @IBAction func logUserIn(sender: AnyObject) {
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func restCall(url: NSString) {
        
        var prodServer = "http://api.mydealerlot.com/api/v3/mobile"
        var qaServer = "http://204.193.146.106:8060/api/v3/mobile"
        
        var endPoint = NSURL(string: prodServer + "/validate_login")
        var data = NSData(contentsOfURL: endPoint!)
        
        var err: NSError?
        
        let request = NSMutableURLRequest(URL: endPoint!)
        
        request.HTTPMethod = "POST"
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body, options: nil, error: &err)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request { (data, response, error) -> Void in
            let json:JSON = JSON(data: data)
            onCompletion(json, err)
        })
        task.resume()
        
        print(data)
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        //set Username/Password background text to be gray so as not to clash with the background color
        username.attributedPlaceholder = NSAttributedString(string: "Username", attributes:[NSForegroundColorAttributeName:UIColor.grayColor()])
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes:[NSForegroundColorAttributeName:UIColor.grayColor()])
        restCall("")
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    

}
