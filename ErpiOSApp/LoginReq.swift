//
//  LoginReq.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/23.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation

enum LoginReq:String{
    case signinUrl = "auth/signin";
    case signoutUrl = "auth/signout";
    case verifyUrl = "auth/verify";
}