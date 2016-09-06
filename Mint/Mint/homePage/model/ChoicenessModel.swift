//
//  ChoicenessModel.swift
//  Mint
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChoicenessModel: NSObject {
    
    var message: NSString?
    var code:NSNumber?
    var data:DataModel?
    
    class func parseModel(data:NSData)->ChoicenessModel{
        let model = ChoicenessModel()
        let jsonData = JSON(data:data)
        model.message = jsonData["message"].string
        
        model.code = jsonData["code"].number
        let dataModel = jsonData["data"]
        model.data = DataModel.perseModel(dataModel)
        
        return model
    }
    
}

class DataModel:NSObject{
    var items: Array<ItemsModel>?
    var paging: PagingModel?
    
    class func perseModel(jsonData:JSON)->DataModel{
        let model = DataModel()
        let items = jsonData["items"]
        var array = Array<ItemsModel>()
        
        for (_,subjson) in items{
            let itemsModel = ItemsModel.parseModel(subjson)
            array.append(itemsModel)
        }
        
        model.items = array
        let pagingData = jsonData["paging"]
        model.paging = PagingModel.parseModel(pagingData)
        return model
    }
    
    
}


class PagingModel: NSObject{
    var next_url: NSString?
    class func parseModel(jsonData:JSON)->PagingModel{
        let model = PagingModel()
        model.next_url = jsonData["next_url"].string
        return model
    
    }

}


class ItemsModel: NSObject{
    var content_url: NSString?
    var cover_image_url: String?
    var created_at: NSNumber?
    
    var editor_id: NSString?
    var id: NSNumber?
    var labels: NSString?
    
    var liked: Bool?
    var likes_count: NSNumber?
    var published_at: NSNumber?
    
    var share_msg: NSString?
    var short_title: NSString?
    var status: NSNumber?
    
    var template: NSString?
    var title: String?
    var type: NSString?
    
    var updated_at: NSNumber?
    var url: NSString?

    class func parseModel(jsonData:JSON)->ItemsModel{
       
        let model = ItemsModel()
        model.content_url = jsonData["content_url"].string
        model.cover_image_url = jsonData["cover_image_url"].string
       
        model.created_at = jsonData["created_at"].number
        model.editor_id = jsonData["editor_id"].string
        model.id = jsonData["id"].number
        
        model.labels = jsonData["labels"].string
        model.liked = jsonData["liked"].bool
        model.likes_count = jsonData["likes_count"].number
        model.published_at = jsonData["published_at"].number
        model.share_msg = jsonData["share_msg"].string
        model.short_title = jsonData["short_title"].string
        model.status = jsonData["status"].number
        model.template = jsonData["template"].string
        model.title = jsonData["title"].string
        
        model.type = jsonData["type"].string
        model.updated_at = jsonData["updated_at"].number
        
        model.url = jsonData["url"].string
        
        return model
        
    }
    
    
}

