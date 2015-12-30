//
//  CityMediaType.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/29.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import UIKit
import ObjectMapper

class CityMediaType: BaseModel {
    
    var uid:String!;
    var cityname:String!;
    var comment:String!;
    
    var mediatypelist:[MediaType]!;
    
    override func mapping(map: Map) {
        
        uid <- map["uid"];
        cityname <- map["cityname"];
        comment <- map["comment"];
        mediatypelist <- map["mediatypelist"];
    }
    
}

class MediaType: BaseModel {
    
    var uid:String!;
    var medianame:String!;
    var isspecial:Bool!; 
    
    var isCheck:Bool = false;
    
    override func mapping(map: Map) {
        
        uid <- map["uid"];
        medianame <- map["medianame"];
        isspecial <- map["isspecial"];
    }
}
