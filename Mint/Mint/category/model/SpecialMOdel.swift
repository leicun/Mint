//
//  SpecialMOdel.swift
//  Mint
//
//  Created by qianfeng on 16/8/22.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

import SwiftyJSON

class SpecialMOdel: NSObject {
    var code: NSNumber?
    var data: SpecialDataMOdel?
    var message: NSString?
    class func parseModel(data:NSData)->SpecialMOdel{
        let jsodata = JSON(data: data)
        let model = SpecialMOdel()
        model.code = jsodata["code"].number
        model.message = jsodata["message"].string
        
        let dataModel = jsodata["data"]
        model.data = SpecialDataMOdel.parseModel(dataModel)
        return model
        
    }

}


class SpecialDataMOdel: NSObject{
    var channel_groups: Array<SpecialDataGroupsMOdel>?
    
    class func parseModel(jsonData: JSON) -> SpecialDataMOdel {
        
        let model = SpecialDataMOdel()
        
        var array = Array<SpecialDataGroupsMOdel>()
        for (_,subjson) in jsonData["channel_groups"] {
            let cgModel = SpecialDataGroupsMOdel.parseModel(subjson)
            array.append(cgModel)
        }
        model.channel_groups = array
        
        return model
        
    }
    
}

class SpecialDataGroupsMOdel: NSObject{
    
    var channels: Array<SpecialDataChannelsMOdel>?
    var id: NSNumber?
    var name: String?
    var order: NSNumber?
    var status: NSNumber?
    
    class func parseModel(jsonData: JSON) -> SpecialDataGroupsMOdel {
        
        let model = SpecialDataGroupsMOdel()
        model.id = jsonData["id"].number
        model.name = jsonData["name"].string
        model.order = jsonData["order"].number
        model.status = jsonData["status"].number
        var array = Array<SpecialDataChannelsMOdel>()
        for (_,subJson) in jsonData["channels"] {
            let tmpArray = SpecialDataChannelsMOdel.parseModel(subJson)
            array.append(tmpArray)
        }
        model.channels = array
        
        return model
        
    }
    
}

class SpecialDataChannelsMOdel: NSObject{
    var group_id: NSNumber?
    var icon_url: String?
    var id: NSNumber?
    var items_count: NSNumber?
    var name: String?
    var order: NSNumber?
    var status: NSNumber?
    
    class func parseModel(jsonData: JSON)-> SpecialDataChannelsMOdel{
        let model = SpecialDataChannelsMOdel()
        model.group_id = jsonData["group_id"].number
        model.icon_url = jsonData["icon_url"].string
        model.id = jsonData["id"].number
        model.items_count = jsonData["items_count"].number
        model.name = jsonData["name"].string
        model.order = jsonData["order"].number
        model.status = jsonData["status"].number
        return model
    }
    
    
    
}



