//
//  File.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/10.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation
import MBProgressHUD

struct BlockMsg {
    
    static func showLoading(view:UIView!) -> MBProgressHUD{
        let HUD = MBProgressHUD.showHUDAddedTo(view, animated: true);
        
        HUD.labelText = "正在加载 ...";
        HUD.dimBackground = true;
        
        HUD.show(true);
        return HUD;
    }
    
    static func hideLoading(HUD:MBProgressHUD){
        HUD.removeFromSuperview();
    }
    
    static func showText(view:UIView!,msg:String!,executAction:(() -> Void)?,completeAction:(() -> Void)?){
        
        let HUD = MBProgressHUD.showHUDAddedTo(view, animated: true);
        HUD.mode = MBProgressHUDMode.Text;
        HUD.labelText = msg;
        HUD.detailsLabelText = "详细信息";
        
        HUD.showAnimated(true
            , whileExecutingBlock: { () -> Void in
                if let e = executAction {
                    e();
                }
            }) { () -> Void in
                if let c = completeAction{
                    
                    HUD.removeFromSuperview();
                    c();
                }
        }
    
    }
    static func showText(view:UIView!,msg:String,afterDelay:Double){
        let HUD = MBProgressHUD.showHUDAddedTo(view, animated: true);
        HUD.mode = MBProgressHUDMode.Text;
        HUD.dimBackground  = true;
        HUD.labelText = msg;
        HUD.detailsLabelText = "详细信息";
        
        HUD.show(true);
        
        
        
        HUD.hide(true, afterDelay: afterDelay);
    }
    static func showText(view:UIView!,msg:String,afterDelay:UInt32,completion:(() -> Void)?){
        let HUD = MBProgressHUD.showHUDAddedTo(view, animated: true);
        HUD.mode = MBProgressHUDMode.Text;
        HUD.dimBackground  = true;
        HUD.labelText = msg;
        
        HUD.showAnimated(true
            , whileExecutingBlock: { () -> Void in
                sleep(afterDelay)
            }) { () -> Void in
                HUD.removeFromSuperview();
                if let c = completion{
                    c();
                }
        }
        
        
        
    }
    
    static func showDuring(view:UIView!,completeAction:(() -> Void)?){
        let HUD = MBProgressHUD.showHUDAddedTo(view, animated: true);
        HUD.mode = MBProgressHUDMode.Text;
        HUD.labelText = "操作完成";
        
        HUD.showAnimated(true
            , whileExecutingBlock: { () -> Void in
                sleep(2)
            }) { () -> Void in
                if let c = completeAction{
                    
                    HUD.removeFromSuperview();
                    c();
                }
        }
    }
}