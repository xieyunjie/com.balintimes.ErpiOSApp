//
//  AppSetting.swift
//  merp
//
//  Created by yunjie Xie on 15/12/7.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation



struct AppSetting {
    static let BaseUrl = "http://172.16.2.12:3322/";
    
    enum CrmUrl:String {
        case registerCustomerUrl = "crm/registercustomer";
        case signCustomerUrl = "crm/signcustomer";
        case cityUrl = "crm/cities",provinceUrl = "crm/province";
    }
}