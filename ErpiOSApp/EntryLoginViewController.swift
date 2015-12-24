//
//  EntryLoginViewController.swift
//  merp
//
//  Created by yunjie Xie on 15/11/18.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class EntryLoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    @IBAction func btnLoginClick(sender: AnyObject) {
        
        self.login();
        
    }
    @IBAction func btnResetClick(sender: AnyObject) {
        
        self.txtPassword.text = "";
        self.txtUserName.text = "";
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.txtUserName{
            self.txtPassword.becomeFirstResponder();
        }
        else if textField == self.txtPassword{
            self.login();
        }
        
        return true;
    }
    
    private func login(){
        self.resignFirstResponder();
        
        if txtUserName.text != nil && self.txtPassword.text != nil{
            
            let username = self.txtUserName.text!;
            let password = self.txtPassword.text!;
            
            let block = BlockMsg.showLoading(self.view);
            
            RequestApi.post(LoginReq.signinUrl.rawValue, ["username":username,"password":password], completion: { (res:ResponseData<WebUser>) -> Void in
                
                BlockMsg.hideLoading(block);
                
                if res.success == true{
                    UserDefaultsData.userToken(res.model?.token);
                    self.performSegueWithIdentifier("entryErpList", sender: self);
                }
                else{
                    BlockMsg.showText(self.view, msg: "登录失败", afterDelay: 2.5);
                    self.txtUserName.becomeFirstResponder();
                }
                
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtUserName.delegate = self;
        self.txtPassword.delegate = self;
        // Do any additional setup after loading the view.
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
