//
//  LogonReturncommoditModel.swift
//  Mint
//
//  Created by qianfeng on 16/9/5.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import SwiftyJSON

class LogonReturncommoditModel: NSObject {
    var code: NSNumber?
    var data: LogonReturncommoditDataModel?
    var message: String?
    
    class func parseModel(data: NSData)-> LogonReturncommoditModel {
        let jsonData = JSON(data: data)
        let model = LogonReturncommoditModel()
        model.code = jsonData["code"].number
        model.message = jsonData["message"].string
        model.data = LogonReturncommoditDataModel.parseModel(jsonData["data"])
        return model
    }
}

class LogonReturncommoditDataModel: NSObject {
    var favorite_lists: Array<LogonReturncommoditFavoriteModel>?
    var paging: LogonCommiditPagingModel?
    class func parseModel(jsonData: JSON)-> LogonReturncommoditDataModel {
        let model = LogonReturncommoditDataModel()
        model.paging = LogonCommiditPagingModel.parseModel(jsonData["paging"])
        var array = Array<LogonReturncommoditFavoriteModel>()
        for (_,subjson) in jsonData["favorite_lists"] {
            let tmpAarray = LogonReturncommoditFavoriteModel.parseModel(subjson)
            array.append(tmpAarray)
        }
        model.favorite_lists = array
        return model
    }
    
}


class LogonCommiditPagingModel: NSObject {
    var next_url: NSString?
    class func parseModel(jsonData: JSON)-> LogonCommiditPagingModel {
        let model = LogonCommiditPagingModel()
        model.next_url = jsonData["next_url"].string
        return model
    }
}


class LogonReturncommoditFavoriteModel: NSObject {
    
    var cover_image_url: String?
    var created_at: NSNumber?
    var _description: String?
    
    var head_image_url: String?
    var id: NSNumber?
    var items_count: NSNumber?
    
    var name: String?
    var _public: Bool?
    var updated_at: NSNumber?
    
    var url: String?
    var user_id: NSNumber?
    
    class func parseModel(jsonData: JSON)-> LogonReturncommoditFavoriteModel {
        let model = LogonReturncommoditFavoriteModel()
        
        model.cover_image_url = jsonData["cover_image_url"].string
        model.created_at = jsonData["created_at"].number
        model._description = jsonData["description"].string
        
        model.head_image_url = jsonData["head_image_url"].string
        model.id = jsonData["id"].number
        model.items_count = jsonData["items_count"].number
        
        model.name = jsonData["name"].string
        model._public = jsonData["public"].bool
        model.updated_at = jsonData["updated_at"].number

        model.url = jsonData["url"].string
        model.user_id = jsonData["user_id"].number
        return model
    }
}











