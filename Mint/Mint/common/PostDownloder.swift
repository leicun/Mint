//
//  PostDownloder.swift
//  Mint
//
//  Created by qianfeng on 16/9/1.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import Alamofire

protocol PostDownloderDelegate: NSObjectProtocol {
    func downloder(downloder: PostDownloder, error: NSError)
    func downloder(downloder: PostDownloder, data: NSData?)
}


class PostDownloder: NSObject {
    weak var delegate: PostDownloderDelegate?
    
    func postDownlod(urlString:String,params:Dictionary<String,String>){
        let newParam = params
        //http://api.bohejiaju.com/v1/account/signin
        //mobile=13693040869&password=lei1123cun
               Alamofire.request(.POST, urlString, parameters: newParam, encoding: ParameterEncoding.URL, headers: nil).responseData { (response) in
            switch response.result {
            case .Failure(let error):
                self.delegate?.downloder(self, error: error)
            case .Success:
                self.delegate?.downloder(self, data: response.data!)
                
            }
        }
    }

}
