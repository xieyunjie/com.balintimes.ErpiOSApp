//
//  CrmReq.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/23.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation

enum CrmReq:String {
    case registerCustomerUrl = "crm/register";
    case signCustomerUrl = "crm/sign";
    case attUrl = "crm/att";
    case listUrl = "crm/list";
    case mediaTypeUrl = "crm/mediatype";
    
    case cityUrl = "crm/cities",provinceUrl = "crm/province";
}