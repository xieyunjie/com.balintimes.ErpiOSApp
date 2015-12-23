//
//  UserDefaultsData.swift
//  ErpiOSApp
//
//  Created by AlexXie on 15/12/22.
//  Copyright © 2015年 balintimes. All rights reserved.
//

import Foundation
import JWT
import ObjectMapper


struct UserDefaultsData{
    
    private static let  _userdefaultsdata = NSUserDefaults.standardUserDefaults();
    
    //
    static func userToken(token:String? = nil) -> String? {
        
        if token == nil{
            if _userdefaultsdata.objectForKey("token") != nil{
                return _userdefaultsdata.objectForKey("token") as? String;
            }
            else{
                return nil;
            }
            
        }
        else{
        
            _userdefaultsdata.setObject(token, forKey: "token");
            return token!;
        }
        
    }
    static func resetUserToken(){
        _userdefaultsdata.removeObjectForKey("token");
    }
    
    static func decodeUser() -> WebUser?{
        
        do{
            let payload = try JWT.decode(userToken()!, algorithm: Algorithm.HS256("secret"));
        
            return Mapper<WebUser>().map(payload)!;
        }
        catch{
            print("Failed to decode JWT: \(error)")
        }
        
        return nil;
        
    }
    
    static func userName(name:String?=nil) -> String{
        if name == nil{
            if _userdefaultsdata.objectForKey("token") != nil{
                return _userdefaultsdata.objectForKey("token") as! String;
            }
            else{
                return "";
            }
            
        }
        else{
            
            _userdefaultsdata.setObject(name, forKey: "token");
            return name!;
        }
    }
    
}

