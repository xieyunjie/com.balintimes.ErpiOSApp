//
//  EntryBlankViewController.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/23.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit

class EntryBlankViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if UserDefaultsData.userToken() != nil{
            
            let block = BlockMsg.showLoading(self.view);
            RequestApi.get(LoginReq.verifyUrl.rawValue, nil, completion: { (res:ResponseData<BaseModel>) -> Void in
                
                BlockMsg.hideLoading(block);
                
                if res.success == false{
                    
                    self.performSegueWithIdentifier("segueToLoginView", sender: self);
                    UserDefaultsData.resetUserToken();
                    //                    let board =  UIStoryboard.init(name: "Entry", bundle: nil);
                    //                    let rootViewCtrl:UITabBarController  = board.instantiateViewControllerWithIdentifier("entryMainView") as! UITabBarController;
                    //                    self.window?.rootViewController = rootViewCtrl;
                    //
                    //                    self.window?.makeKeyAndVisible()
                }
                else{
                    self.performSegueWithIdentifier("segueToMainView", sender: self);
                    //                    let board =  UIStoryboard.init(name: "Entry", bundle: nil);
                    //                    let rootViewCtrl:EntryLoginViewController = board.instantiateViewControllerWithIdentifier("entryLoginView") as! EntryLoginViewController;
                    //                    self.window?.rootViewController = rootViewCtrl;
                    //
                    //                    self.window?.makeKeyAndVisible()
                }
            })
        }
        else{
            self.performSegueWithIdentifier("segueToLoginView", sender: self);
            UserDefaultsData.resetUserToken();
            //            let board =  UIStoryboard.init(name: "Entry", bundle: nil);
            //            let rootViewCtrl:EntryLoginViewController = board.instantiateViewControllerWithIdentifier("entryLoginView") as! EntryLoginViewController;
            //            self.window?.rootViewController = rootViewCtrl;
            //
            //            self.window?.makeKeyAndVisible()
            
        }
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
