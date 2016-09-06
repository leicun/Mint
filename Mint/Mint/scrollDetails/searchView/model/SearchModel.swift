//
//  SearchModel.swift
//  Mint
//
//  Created by qianfeng on 16/8/28.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchModel: NSObject {
    var code: NSNumber?
    var data: SearchDataModel?
    var message: String?
    
    class func parseModel(data:NSData)-> SearchModel {
        let jsonData = JSON(data: data)
        let model = SearchModel()
        model.code = jsonData["code"].number
        model.message = jsonData["message"].string
        model.data = SearchDataModel.parseModel(jsonData["data"])
        return model
    }
}

class SearchDataModel: NSObject {
    var hot_words: NSArray?
    var placeholder: String?
    
    class func parseModel(jsonData: JSON)-> SearchDataModel {
        let model = SearchDataModel()
        model.placeholder = jsonData["placeholder"].string
        model.hot_words = jsonData["hot_words"].arrayObject
    return model
    }
}















