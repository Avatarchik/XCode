//
//  ViewController.swift
//  RandomSoundEffects
//
//  Created by Gray Karegeannes on 4/10/15.
//  Copyright (c) 2015 Gray Karegeannes. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()
    var time = 0
    var playing = false
    
    var sounds = ["Heimerdinger.attack01","Veigar Listen"]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.subtype == UIEventSubtype.MotionShake {
            
            if playing == false{
            
                var error: NSError? = nil
                var fileNumber = Int(arc4random_uniform(UInt32(sounds.count)))
                var file = NSBundle.mainBundle().pathForResource(sounds[fileNumber], ofType: "mp3")
                
                player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: file!), error: &error)
                player.play()
                
                
            }
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

