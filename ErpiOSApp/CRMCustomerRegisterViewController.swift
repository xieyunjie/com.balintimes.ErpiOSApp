//
//  CRMCustomerRegisterViewController.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/25.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit


class CRMCustomerRegisterViewController: UIViewController,CRMCustomerRegisterFormControllerDelegate,CRMRegisterMediaTypeControllerDelegate {
    
    var customerRegisterFormCtrl:CRMCustomerRegisterFormController!;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCustomerListClick(sender: AnyObject) {
//        delegate?.backToCustomerList(self);
        self.dismissViewControllerAnimated(true, completion: nil);
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueCRMCustomerRegisterForm"{
            
           self.customerRegisterFormCtrl = segue.destinationViewController as! CRMCustomerRegisterFormController;
            self.customerRegisterFormCtrl.delegate = self;
        }
        else if segue.identifier == "segueCRMMediaType" {
            let mediaTypeCtrl = segue.destinationViewController as! CRMRegisterMediaTypeController;
            mediaTypeCtrl.delegate = self;
            
        }
    }
    func selectMediaType() {
        self.performSegueWithIdentifier("segueCRMMediaType", sender: self);
    }
    
    func CityMediaTypeDone(cityMediaType: [CityMediaType]) {
        
        customerRegisterFormCtrl.setCityMediaType(cityMediaType);
        self.navigationController?.popViewControllerAnimated(true);
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
