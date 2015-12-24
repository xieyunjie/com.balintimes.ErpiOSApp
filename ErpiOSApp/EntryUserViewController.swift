//
//  EntryUserViewController.swift
//  merp
//
//  Created by yunjie Xie on 15/11/18.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class EntryUserViewController: UIViewController {

    @IBOutlet weak var txtJwt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtJwt.text = UserDefaultsData.userToken();

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnExitClick(sender: AnyObject) {
        
        RequestApi.get(LoginReq.signoutUrl.rawValue, nil) { (res:ResponseData<BaseModel>) -> Void in
            
            if res.success == true{
                UserDefaultsData.resetUserToken();
                
                if let w = self.view.window{
                    
                    let board =  UIStoryboard.init(name: "Entry", bundle: nil);
                    let rootViewCtrl:EntryLoginViewController = board.instantiateViewControllerWithIdentifier("entryLoginView") as! EntryLoginViewController;
                    w.rootViewController = rootViewCtrl;
                    
                    w.makeKeyAndVisible()
                    
                }
            }
            else{
                BlockMsg.showText(self.view, msg: "退出失败", afterDelay: 2.5);
            }
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
