//
//  BMMSMPMoviePlayerViewController.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/30.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class BMMSMPMoviePlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnPlayClick(sender: AnyObject) {
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueAVPlayer"{
            
            let ctrl = segue.destinationViewController as! AVPlayerViewController;
            let url = NSURL(string: "http://172.16.2.27:3000/vedio/introduce.mp4");
            
            ctrl.player = AVPlayer(URL: url!);
            
            ctrl.player?.play();
            
        }
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
