//
//  ScrollModel.swift
//  Mint
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import SwiftyJSON

class ScrollModel: NSObject {
    
    var code: NSNumber?
    var data: dataModel?
    var message: NSString?
    
    class func parseModel(data:NSData)->ScrollModel{
        let model = ScrollModel()
       
        let jsonData = JSON(data: data)
        model.code = jsonData["code"].number
        
        model.message = jsonData["message"].string
       
       
        let dataDict = jsonData["data"]
    
        model.data = dataModel.parseModel(dataDict)
       
        return model
    }
}

class dataModel: NSObject{
    var banners: Array<arrayModel>?
    
    class func parseModel(jsonData:JSON)->dataModel{
        let model = dataModel()
        let bannerArray = jsonData["banners"]
        
        var bArray = Array<arrayModel>()
        for (_,subjson) in bannerArray{
            let bannerModel = arrayModel.parseModel(subjson)
           
            bArray.append(bannerModel)
        }
        model.banners = bArray
        return model
    }
}

class arrayModel: NSObject{
    
    var channel:NSString?
    var id:NSNumber?
    var image_url:NSString?
    
    var order:NSNumber?
    var status:NSNumber?
    var target_id:NSNumber?
    
    var target_url:NSString?
    var type:NSString?
    var target:targetModel?
    
    class func parseModel(data:JSON)->arrayModel{
     
       
        let model = arrayModel()


        let jsonData = data
       
       
        model.channel = jsonData["channel"].string
        model.id = jsonData["id"].number
        model.image_url = jsonData["image_url"].string
        model.order = jsonData["order"].number
        model.status = jsonData["status"].number
        model.target_id = jsonData["target_id"].number
        model.target_url = jsonData["target_url"].string
        model.type = jsonData["type"].string
        let dataDict = jsonData["target"]
        model.target = targetModel.parseModel(dataDict)
        return model
    }
    
}

class targetModel: NSObject{
    var banner_image_url: NSString?
    var cover_image_url: NSString?
    var created_at: NSNumber?
    var id: NSNumber?
    var posts_count: NSNumber?
    var status: NSNumber?
    var subtitle: NSString?
    var title: NSString?
    var updated_at: NSNumber?
    
    class func parseModel(jsonData:JSON)->targetModel{
        let model = targetModel()
        model.banner_image_url = jsonData["banner_image_url"].string
        model.cover_image_url = jsonData["cover_image_url"].string
        model.created_at = jsonData["created_at"].number
        model.id = jsonData["id"].number
        model.posts_count = jsonData["posts_count"].number
        model.status = jsonData["status"].number
        model.subtitle = jsonData["subtitle"].string
        model.title = jsonData["title"].string
        model.updated_at = jsonData["updated_at"].number
        return model
    }
    
    
    
}



