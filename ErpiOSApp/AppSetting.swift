//
//  AppSetting.swift
//  merp
//
//  Created by yunjie Xie on 15/12/7.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation



struct AppSetting {
    static let BaseUrl = "http://172.16.2.26:3322/";
    
    enum JWT:String{
        case issuer = "balintimes-issuer";
        case secret = "secret";
        case algorithm = "HS256"; 
    } 
}