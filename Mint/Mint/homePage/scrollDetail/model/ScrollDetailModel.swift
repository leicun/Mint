//
//  ScrollDetailModel.swift
//  Mint
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import SwiftyJSON

//0000
class ScrollDetailModel: NSObject {
    
    var code: NSNumber?
    var data: ScrollDetailDataModel?
    var message: String?
    
    class func parseModel(data: NSData)-> ScrollDetailModel {
        let model = ScrollDetailModel()
        let jsonData = JSON(data: data)
        model.code = jsonData["code"].number
        model.message = jsonData["message"].string
        model.data = ScrollDetailDataModel.parseModel(jsonData["data"])
        return model
    }

}


class ScrollDetailDataModel: NSObject {

    var banner_image_url: String?
    var cover_image_url: String?
    var created_at: String?
    
    var id: String?
    var paging: ScrollDetailPagModel?
    var posts: Array<ScrollDetailPostsModel>?
    
    var posts_count: NSNumber?
    var status: NSNumber?
    var subtitle: String?
    
    var title: String?
    var updated_at: NSNumber?
    
    class func parseModel(jsonData: JSON)-> ScrollDetailDataModel {
        let model = ScrollDetailDataModel()
        model.banner_image_url = jsonData["banner_image_url"].string
        model.cover_image_url = jsonData["cover_image_url"].string
        model.created_at = jsonData["created_at"].string

        model.id = jsonData["id"].string
        model.posts_count = jsonData["posts_count"].number
        model.status = jsonData["status"].number
        model.subtitle = jsonData["subtitle"].string

        model.title = jsonData["title"].string
        model.updated_at = jsonData["updated_at"].number
        model.paging = ScrollDetailPagModel.parseModel(jsonData["paging"])

        var array = Array<ScrollDetailPostsModel>()
        for (_,subjson) in jsonData["posts"] {
            let tmpArray = ScrollDetailPostsModel.parseModel(subjson)
            array.append(tmpArray)
        }
        model.posts = array
        return model
    }

}

class ScrollDetailPagModel: NSObject {
    var next_url: NSString?
    class func parseModel(jsonData: JSON)-> ScrollDetailPagModel {
        let model = ScrollDetailPagModel()
        model.next_url  = jsonData["next_url"].string
        return model
    }
}

class ScrollDetailPostsModel: NSObject {
    var content_url: String?
    var cover_image_url: String?
    var created_at: NSNumber?
    
    var id: NSNumber?
    var label_ids: String?
    var liked: Bool?
    
    var likes_count: NSNumber?
    var published_at: NSNumber?
    var share_msg: String?
    
    var short_title: String?
    var status: NSNumber?
    var title: String?
    
    var updated_at: NSNumber?
    var url: String?

    class func parseModel(jsonData: JSON)->ScrollDetailPostsModel {
        let model = ScrollDetailPostsModel()
        model.content_url = jsonData["content_url"].string
        model.cover_image_url = jsonData["cover_image_url"].string
        model.created_at = jsonData["created_at"].number
        
        model.id = jsonData["id"].number
        model.label_ids = jsonData["label_ids"].string
        model.liked = jsonData["liked"].bool
        
        model.likes_count = jsonData["likes_count"].number
        model.published_at = jsonData["published_at"].number
        model.share_msg = jsonData["share_msg"].string
        
        model.short_title = jsonData["short_title"].string
        model.status = jsonData["status"].number
        model.title = jsonData["title"].string
        
        model.updated_at = jsonData["updated_at"].number
        model.url = jsonData["url"].string
    
        
        
        return model
        
        
    
    }
    


}




















