//
//  Customer.swift
//  merp
//
//  Created by AlexXie on 15/12/9.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation
import ObjectMapper

class Customer: BaseModel {
    
    var id:String!;
    var name:String!;
    var industry:String!;
    var province:String!;
    var city:String!;
    
    var address:String?;
    var phonenumber:String?;
    var zipcode:String?;
    var comment:String?;
    
    var brandname:String?;
    var status:String?;
    var signDate:String!;
    //    override func mapping(map: Map) {
    //
    //    }
     
    func ToDictionory() -> Dictionary<String,AnyObject>{
        
        var dic = Dictionary<String,AnyObject>();
        
        dic["id"] = self.id;
        dic["name"] = self.name!;
        dic["industry"] = self.industry!;
        dic["province"] = self.province!;
        dic["city"] = self.city!;
        
        dic["address"] = self.address;
        dic["phonenumber"] = self.phonenumber;
        dic["zipcode"] = self.zipcode;
        dic["comment"] = self.comment;
        
        dic["brandname"] = self.brandname;
        dic["status"] = self.status;
        dic["signDate"] = self.signDate;
        
        return dic;
    }
    
    override func mapping(map: Map) {
        
        id <- map["id"];
        name <- map["name"];
        industry <- map["industry"];
        province <- map["province"];
        city <- map["city"];
        address <- map["address"];
        phonenumber <- map["phonenumber"];
        zipcode <- map["zipcode"];
        comment <- map["comment"];
        brandname <- map["brandname"];
        status <- map["status"];
        
    }
}