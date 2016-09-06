//
//  TitleModel.swift
//  Mint
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import SwiftyJSON
class TitleModel: NSObject {
    var code: NSNumber?
    var data: TitleDataModel?
    var message: String?
    
    class func parseModel(data: NSData)-> TitleModel {
        let jsonData = JSON(data: data)
        let model = TitleModel()
        model.code = jsonData["code"].number
        model.message = jsonData["message"].string
        let dataModel = jsonData["data"]
        model.data = TitleDataModel.parseModel(dataModel)
        return model
    }
    

}


class TitleDataModel: NSObject {
    var candidates: Array<TitleCandidatesModel>?
    var channels: Array<TitleChannelsModle>?
    
    class func parseModel(jsonData: JSON)-> TitleDataModel {
        let model = TitleDataModel()
        var canArray = Array<TitleCandidatesModel>()
        for (_,subjson) in jsonData["candidates"] {
            let tmpArray = TitleCandidatesModel.parseModel(subjson)
            canArray.append(tmpArray)
        }
        model.candidates = canArray
        
        var chanArray = Array<TitleChannelsModle>()
        for (_,subJson) in jsonData["channels"] {
            let tmpArray = TitleChannelsModle.parseModel(subJson)
            chanArray.append(tmpArray)
        }
        model.channels = chanArray
        return model
    
    }
    
    

}

class TitleCandidatesModel: NSObject {
    var editable: Bool?
    var id: NSNumber?
    var name: String?
    class func parseModel(jsonData: JSON)-> TitleCandidatesModel {
        let model = TitleCandidatesModel()
        model.editable = jsonData["editable"].bool
        model.id = jsonData["id"].number
        model.name = jsonData["name"].string
        return model
    }

}

class TitleChannelsModle: NSObject {
    var editable: Bool?
    var id: NSNumber?
    var name: String?
    class func parseModel(jsonData: JSON)-> TitleChannelsModle {
        let model = TitleChannelsModle()
        model.editable = jsonData["editable"].bool
        model.id = jsonData["id"].number
        model.name = jsonData["name"].string
        
        return model
    
    }
}
















