//
//  Province.swift
//  BLActionPickerView
//
//  Created by yunjie Xie on 15/11/25.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation
import ObjectMapper

class Province:BaseModel{
    var id:String?;
    var name:String?
    var createtime:NSDate?
    
    override func mapping(map: Map) {
        
        id <- map["id"];
        name <- map["name"];
        createtime <- map["createtime"];

    }
}
