
//
//  SingIeitmModel.swift
//  Mint
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import SwiftyJSON

class SingIeitmModel: NSObject {
    var code: NSNumber?
    var data: SingDataModel?
    var message: NSString?
    class func parseModel(data:NSData)->SingIeitmModel{
        
        let model = SingIeitmModel()
        let jsonData = JSON(data: data)
        model.code = jsonData["code"].number
        model.message = jsonData["message"].string
        let data = jsonData["data"]
        model.data = SingDataModel.parseModel(data)
        
      
        return model
    }
    
}

class SingDataModel:NSObject{

     var items: Array<ItemsDataModel>?
     var paging: PagModel?
    
     class func parseModel(jsonData: JSON)->SingDataModel{
        let model = SingDataModel()
        let itemsArray = jsonData["items"]
        
        var itemArray = Array<ItemsDataModel>()
        
        for (_,subjson) in itemsArray{
            let itmeModel = ItemsDataModel.parseModel(subjson)
            itemArray.append(itmeModel)
        }
        model.items = itemArray
        
        let pagin = jsonData["PagModel"]
        model.paging = PagModel.parseModel(pagin)
        return model
    }
    
    
    
}

class PagModel: NSObject {
    var next_url: NSString?
    class func parseModel(jsonData: JSON)->PagModel{
        let model = PagModel()
        model.next_url = jsonData["next_url"].string
        return model
    }
    
}

class ItemsDataModel: NSObject{
    var data: TypeModel?
    var _type: NSString?
    
    class func parseModel(jsonData: JSON)->ItemsDataModel{
        let model = ItemsDataModel()
        let data = jsonData["data"]
        model.data = TypeModel.parseModel(data)
        model._type = jsonData["type"].string
        
        
        return model
        
        
    }
    
}


class TypeModel: NSObject{
    
    
    var brand_id: NSString?
    var brand_order: NSNumber?
    var category_id: NSString?
    
    var cover_image_url: String?
    var created_at: NSNumber?
    var _description: NSString?
    
    var editor_id: NSNumber?
    var favorites_count: NSNumber?
    var id: NSNumber?
    
    var image_urls: String?
    var is_favorite: NSNumber?
    var name: String?
    
    var post_ids: NSString?
    var price: NSString?
    var purchase_id: NSNumber?
    
    var purchase_status: NSNumber?
    var purchase_type: NSNumber?
    var purchase_url: NSString?
    
    var subcategory_id: NSString?
    var updated_at: NSNumber?
    var url: NSString?

    class func parseModel(jsonData:JSON)->TypeModel{
        
        let model = TypeModel()
        model.brand_id = jsonData["brand_id"].string
        model.brand_order = jsonData["brand_order"].number
        model.category_id = jsonData["category_id"].string
        
        model.cover_image_url = jsonData["cover_image_url"].string
        model.created_at = jsonData["created_at"].number
        model._description = jsonData["description"].string
        
        model.editor_id = jsonData["editor_id"].number
        model.favorites_count = jsonData["favorites_count"].number
        model.id = jsonData["id"].number
        
        model.image_urls = jsonData["image_urls"].string
        model.is_favorite = jsonData["is_favorite"].number
        model.name = jsonData["name"].string
       
        model.post_ids = jsonData["post_ids"].string
        model.price = jsonData["price"].string
        model.purchase_id = jsonData["purchase_id"].number
        
        model.purchase_status = jsonData["purchase_status"].number
        model.purchase_type = jsonData["purchase_type"].number
        model.purchase_url = jsonData["purchase_url"].string
        
        model.subcategory_id = jsonData["subcategory_id"].string
        model.updated_at = jsonData["updated_at"].number
        model.url = jsonData["url"].string

        return model
        
    
    }

}




