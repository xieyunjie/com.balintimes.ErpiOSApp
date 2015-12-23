//
//  User.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/22.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation
import ObjectMapper

class WebUser: BaseModel {
    
    var uid:String?;
    var name:String?;
    var password:String?;
    var redisToken:String?;
    var token:String?;
    
    
    override func mapping(map: Map) {
        
        uid <- map["uid"];
        name <- map["name"];
        password <- map["password"];
        redisToken <- map["redisToken"];
        token <- map["token"];
        
    }
}