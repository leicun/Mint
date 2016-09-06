//
//  LogonRtrurnModel.swift
//  Mint
//
//  Created by qianfeng on 16/9/1.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import SwiftyJSON

class LogonRtrurnModel: NSObject {
    var code: NSNumber?
    var data: LogonRtnDataModel?
    var message: String?
    
    class func parseModel(data: NSData)-> LogonRtrurnModel{
        let jsonData = JSON(data:  data)
        let model = LogonRtrurnModel()
        model.code = jsonData["code"].number
        model.message = jsonData["message"].string
        model.data = LogonRtnDataModel.pardeModel(jsonData["data"])
        return model
    }

}

class  LogonRtnDataModel: NSObject {
    var avatar_url: String?
    var can_mobile_login: Bool?
    var guest_uuid: String?
    
    var id: NSNumber?
    var mobile: String?
    var nickname: String?
    
    var role: String?
    class func pardeModel(jsonData: JSON)-> LogonRtnDataModel {
        let model = LogonRtnDataModel()
        model.avatar_url = jsonData["avatar_url"].string
        model.can_mobile_login = jsonData["can_mobile_login"].bool
        model.guest_uuid = jsonData["guest_uuid"].string
        
        model.id = jsonData["id"].number
        model.mobile = jsonData["mobile"].string
        model.nickname = jsonData["nickname"].string
        
        model.role = jsonData["role"].string
        return model
        
    }
}
