//
//  BaseModel.swift
//  merp
//
//  Created by AlexXie on 15/12/9.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation
import ObjectMapper


class BaseModel: NSObject, Mappable{
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
    }
}