//
//  CommendModel.swift
//  Mint
//
//  Created by qianfeng on 16/8/29.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommendModel: NSObject {
    var code: NSNumber?
    var data: CommendityDataMoel?
    var message: String?
    class func parseModel(data: NSData)-> CommendModel {
        let model = CommendModel()
        let jsonData = JSON(data: data)
        model.code = jsonData["code"].number
        model.message = jsonData["message"].string
        model.data = CommendityDataMoel.parseModel(jsonData["data"])
        return model
    }
}

class CommendityDataMoel:NSObject {
    var items: Array<CommendityItemsModel>?
    var paging: CommendityPagingModel?

    class func parseModel(jsonData: JSON)-> CommendityDataMoel {
        let model = CommendityDataMoel()
        var array = Array<CommendityItemsModel>()
        for (_,subjson) in jsonData["items"] {
            let tmpArray = CommendityItemsModel.parseModel(subjson)
            array.append(tmpArray)
        }
        model.items = array
        
        model.paging = CommendityPagingModel.parseModel(jsonData["paging"])
        
        return model
        
    }
    
}

class CommendityItemsModel: NSObject {
    var cover_image_url: String?
    var _description: String?
    var favorites_count: NSNumber?
    
    var id: NSNumber?
    var liked: Bool?
    var likes_count: NSNumber?
    
    var name: String?
    var price: String?
    
    class func parseModel(jsondData: JSON)-> CommendityItemsModel {
         let modle = CommendityItemsModel()
         modle.cover_image_url = jsondData["cover_image_url"].string
         modle._description = jsondData["description"].string
         modle.favorites_count = jsondData["favorites_count"].number
        
        modle.id = jsondData["id"].number
        modle.liked = jsondData["liked"].bool
        modle.likes_count = jsondData["likes_count"].number

        modle.name = jsondData["name"].string
        modle.price = jsondData["price"].string
        
        return modle

    }

    
}

class CommendityPagingModel: NSObject {
    var next_url: String?
    class func parseModel(jsonData: JSON)-> CommendityPagingModel {
        let model = CommendityPagingModel()
        model.next_url = jsonData["next_url"].string
        return model
    }

}

