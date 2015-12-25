//
//  CRMCustomerRegisterViewController.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/25.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class CRMCustomerRegisterViewController: UIViewController,CRMCustomerRegisterFormControllerDelegate {

    var customerRegisterFormCtrl:CRMCustomerRegisterFormController!;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueCRMCustomerRegisterForm"{
            
           self.customerRegisterFormCtrl = segue.destinationViewController as! CRMCustomerRegisterFormController;
            self.customerRegisterFormCtrl.delegate = self;
        }
    }
    func selectMediaType() {
        self.performSegueWithIdentifier("segueCRMMediaType", sender: self);
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
