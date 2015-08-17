//
//  ViewController.swift
//  Storing Images
//
//  Created by Gray Karegeannes on 4/10/15.
//  Copyright (c) 2015 Gray Karegeannes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bmw: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let url = NSURL(string: "http://oilreset.com/wp-content/uploads/2015/03/2015-BMW-3-Series.jpg")
//        
//        let urlRequest = NSURLRequest(URL: url!)
//        
//        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
//            
//            response, data, error in
//            
//            if error != nil {
//                println("There was an error")
//            }
//            else{
//                let image = UIImage(data: data)
//                
//                //self.bmw.image = image
//                
//                var documentsDirectory:String?
//                
//                var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
//                
//                if paths.count > 0 {
//                    documentsDirectory = paths[0] as? String
//                    
//                    var savePath = documentsDirectory! + "/bmw.jpg"
//                    
//                    NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
//                    
//                    self.bmw.image = UIImage(named: savePath)
//                    
//                }
//            }
//            
//        })
        
        
        
                        var documentsDirectory:String?
        
                        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
                        if paths.count > 0 {
                            documentsDirectory = paths[0] as? String
        
                            var savePath = documentsDirectory! + "/bmw.jpg"
               
                            self.bmw.image = UIImage(named: savePath)
                            
                        }

        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

