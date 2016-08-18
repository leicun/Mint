//
//  Downloder.swift
//  Mint
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

protocol DownloderDelegate:NSObjectProtocol {
    func downloder(downloder:Downloder, error:NSError)
    func downloder(downloder:Downloder, data:NSData?)
}

class Downloder: NSObject {
    var delegate:DownloderDelegate?

    func downloderFunc(urlString:String){
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            if let err = error{
                self.delegate?.downloder(self, error: err)
            }else{
                let http = response as! NSHTTPURLResponse
                if http.statusCode == 200{
                    self.delegate?.downloder(self, data: data!)
                }else{
                    let myError = NSError(domain: urlString, code: http.statusCode, userInfo: ["msg":"下载失败"])
                    self.delegate?.downloder(self, error: myError)
                }
            
            }
            
        }
    
        task.resume()
    }
    
    
}
