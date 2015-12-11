//
//  CRMCustomerSignViewController.swift
//  merp
//
//  Created by yunjie Xie on 15/12/7.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

protocol CRMCustomerSignViewControllerDelegate:NSObjectProtocol{
    
    func saveSuccessful(success:Bool);
    
}

class CRMCustomerSignViewController: UIViewController,CRMCustomerSignFormControllerDelegate {

    
    var formController:CRMCustomerSignFormController!;
    var editCustomer:Customer?;
    var editBrand:Brand?;
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnSave: UIButton!
    
    var delegate:CRMCustomerSignViewControllerDelegate?;
    
    
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
        
        let hub = BlockMsg.showLoading(self.view);
        
        RequestApi.post(AppSetting.CrmUrl.signCustomerUrl.rawValue, result.customer.ToDictionory()) { (res:ResponseData<BaseModel>) -> Void in
            BlockMsg.hideLoading(hub);
            
            if res.success == true{
                
                BlockMsg.showText(self.view, msg: res.msg, afterDelay: 2, completion: { () -> Void in
                    print("保存成功。");
                })
                
            }
            else{
                BlockMsg.showText(self.view, msg: res.msg, afterDelay: 1.0);
            }
            
            if let d = self.delegate{
                d.saveSuccessful(res.success);
            }
        }
        
    }
    @IBAction func btnCancelClick(sender: AnyObject) {
        if let d = self.delegate{
            d.saveSuccessful(false);
        }
    }

    @IBAction func btnBackClick(sender: AnyObject) {
        if let d = self.delegate{
            d.saveSuccessful(false);
        }
        else{
            self.dismissViewControllerAnimated(true, completion: nil);
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
