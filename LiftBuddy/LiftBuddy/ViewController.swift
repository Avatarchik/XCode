//
//  ViewController.swift
//  LiftBuddy
//
//  Created by Gray Karegeannes on 5/23/15.
//  Copyright (c) 2015 Gray Karegeannes. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ViewController: UIViewController {
    //access user input from the login page
    @IBOutlet var userAccountField: UITextField!
    
    @IBOutlet var userPasswordField: UITextField!
    
    @IBAction func loginButton(sender: AnyObject) {
        
        var account = userAccountField.text
        var password = userPasswordField.text
        
        Parse.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

