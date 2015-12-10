//
//  DlgMsg.swift
//  SwiftProject
//
//  Created by yunjie Xie on 15/11/18.
//  Copyright © 2015年 yunjie Xie. All rights reserved.
//
 
import UIKit

struct DlgMsg{
    static func alert(title:String,_ message:String,handler:((UIAlertAction) -> Void)?) -> UIAlertController{
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert);
        
        let defaultAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            if let act = handler{
                act(action);
            }
            
        }
        alertView.addAction(defaultAction);
        
        return alertView;
    }
    
    static func alertWebError(handler:((UIAlertAction) -> Void)?,var message:String?) -> UIAlertController{
        
        message = message == nil ? "获取数据出错" : message;
        
        let alertView = UIAlertController(title: "系统提示", message: message, preferredStyle: UIAlertControllerStyle.Alert);
        
        let defaultAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            if let act = handler{
                act(action);
            }
            
        }
        alertView.addAction(defaultAction);
        
        return alertView;
    }
}