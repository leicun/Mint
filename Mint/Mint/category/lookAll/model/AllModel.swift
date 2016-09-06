//
//  AllModel.swift
//  Mint
//
//  Created by qianfeng on 16/8/30.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import SwiftyJSON

class AllModel: NSObject {
    var code: NSNumber?
    var data: AllDataModel?
    var message: String?
    
    class func parseModel(data: NSData)-> AllModel {
        let jsonData = JSON(data: data)
        let model = AllModel()
        model.code = jsonData["code"].number
        model.message = jsonData["mesage"].string
        model.data = AllDataModel.parseModel(jsonData["data"])
        return model
    
    }
    

}

class AllDataModel: NSObject {
    var collections: Array<AllCollectionsModel>?
    var paging:AllPagingModel?
    
    class  func parseModel(jsonData: JSON)-> AllDataModel {
        let model = AllDataModel()
        var array = Array<AllCollectionsModel>()
        for (_,subjson) in jsonData["collections"] {
            let tmpArray = AllCollectionsModel.parseModel(subjson)
            array.append(tmpArray)
        }
        model.collections = array
        model.paging = AllPagingModel.parseModel(jsonData["paging"])
        return model
    }
    
    
}

class AllPagingModel: NSObject {
    var next_url: String?
    class func parseModel(jsonData: JSON)-> AllPagingModel {
        let model = AllPagingModel()
            model.next_url = jsonData["nex_url"].string
        return model
    }
}

class AllCollectionsModel: NSObject {
    var banner_image_url: String?
    var cover_image_url: String?
    var created_at: NSNumber?
    
    var id:NSNumber?
    var posts_count: NSNumber?
    var status: NSNumber?
    
    var subtitle: String?
    var title: String?
    var updated_at: NSNumber?
    
    class func parseModel(jsonData: JSON)-> AllCollectionsModel {
    
        let model = AllCollectionsModel()
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









