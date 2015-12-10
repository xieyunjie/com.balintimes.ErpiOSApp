//
//  AppSetting.swift
//  merp
//
//  Created by yunjie Xie on 15/12/7.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation



struct AppSetting {
    static let BaseUrl = "http://172.16.2.19:3322/";
    
    enum CrmUrl:String {
        case registerCustomerUrl = "crm/register";
        case signCustomerUrl = "crm/sign";
        case attUrl = "crm/att";
        
        case cityUrl = "crm/cities",provinceUrl = "crm/province";
    }
}