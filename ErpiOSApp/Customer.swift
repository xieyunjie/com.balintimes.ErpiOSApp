//
//  Customer.swift
//  merp
//
//  Created by AlexXie on 15/12/9.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation
import ObjectMapper

class Customer: NSObject {
    
    var name:String!;
    var industry:String!;
    var province:String!;
    var city:String!;
    
    var address:String?;
    var phonenumber:String?;
    var zipcode:String?;
    var comment:String?;
    
//    override func mapping(map: Map) {
//        
//    }
    
    func ToDictionory() -> Dictionary<String,AnyObject>{
        
        var dic = Dictionary<String,AnyObject>();
        
        dic["name"] = self.name!;
         dic["industry"] = self.industry!;
         dic["province"] = self.province!;
         dic["city"] = self.city!;
        
         dic["address"] = self.address;
         dic["phonenumber"] = self.phonenumber;
         dic["zipcode"] = self.zipcode;
         dic["comment"] = self.comment;
        
        return dic;
    }
}