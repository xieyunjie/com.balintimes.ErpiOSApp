//
//  CRMCustomerSignViewController.swift
//  merp
//
//  Created by yunjie Xie on 15/12/7.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class CRMCustomerSignViewController: UIViewController,CRMCustomerSignFormControllerDelegate {

    
    var formController:CRMCustomerSignFormController!;
    var editCustomer:Customer?;
    var editBrand:Brand?;
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var btnSave: UIButton! 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnSave.enabled = false;
        self.btnSave.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1);
//        if let  customer = self.editBrand{
//            
//            
//        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func formRequireFieldCheck(finish:Bool){
        print("require check \(finish)");
        
        if finish == true{
            self.btnSave.enabled = true;
            self.btnSave.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1);
        }
        else{
            self.btnSave.enabled = false;
            self.btnSave.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1);
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueCRMCustomerSignForm"{
            self.formController = segue.destinationViewController as! CRMCustomerSignFormController;
            self.formController.delegate = self;
        }
    }
    
    @IBAction func btnSaveClick(sender: AnyObject) {
        
        let result = self.formController.getCustomerAndBrand();
        
        print(result.customer.ToDictionory());
        
    }
    @IBAction func btnCancelClick(sender: AnyObject) {
        
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
