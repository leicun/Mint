//
//  CatetotyModel.swift
//  Mint
//
//  Created by qianfeng on 16/8/22.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import SwiftyJSON

class CategotyModel: NSObject {
    
    var code: NSNumber?
    var data: CategoryDataModel?
    var message: NSString?
    
    class func parseModel(data: NSData)->CategotyModel{
        let jsonData = JSON(data: data)
        let model = CategotyModel()
        model.code = jsonData["code"].number
        model.message = jsonData["message"].string
        let data = jsonData["data"]
        model.data = CategoryDataModel.parseModel(data)
       
        return model
    }
    

}

class CategoryDataModel: NSObject {
    var collections: Array<CollectionsModel>?
    var paging: CategoryPagingModel?
    
    class func parseModel(jsonData: JSON)->CategoryDataModel{
        let model = CategoryDataModel()
        let collArray = jsonData["collections"]
        var tmpArray = Array<CollectionsModel>()
        
        for (_,subjson) in collArray{
           let subModel =  CollectionsModel.parseModel(subjson)
            tmpArray.append(subModel)
        }
        
        model.collections = tmpArray
        let pagingModel = jsonData["paging"]
        model.paging = CategoryPagingModel.parseModel(pagingModel)
        
        return model
        
    
    }
    
}


class CategoryPagingModel: NSObject {
    var next_url: NSString?
    class func parseModel(jsonData: JSON)-> CategoryPagingModel{
        let model = CategoryPagingModel()
        model.next_url = jsonData["next_url"].string
        return model
    }
}


class CollectionsModel: NSObject{

    var banner_image_url: String?
    var cover_image_url: NSString?
    var created_at: NSNumber?
    var id: NSNumber?
    var posts_count: NSNumber?
    var status: NSNumber?
    var subtitle: NSString?
    var title: NSString?
    var updated_at: NSNumber?
    
    class func parseModel(jsonData: JSON)-> CollectionsModel{
        let model = CollectionsModel()
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
