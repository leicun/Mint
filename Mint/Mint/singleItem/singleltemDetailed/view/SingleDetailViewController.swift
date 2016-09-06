//
//  SingleDetailViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class SingleDetailViewController: BaseViewController,UIWebViewDelegate {
    var id:  NSNumber?
    var webView: UIWebView?
    var items: Bool = true
    
    var bgView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addNav()
        creataWebView()
        self.view.backgroundColor = UIColor.whiteColor()
        
    }
    
    func addNav(){
        addNavTitle("商品详情")
        addNavBtn(nil
            , bgImage: "分享图标黑色", target: self, action: #selector(shareBtn), isLeft: false)
        addNavBtn(nil
            , bgImage: "left", target: self, action: #selector(nextBtn), isLeft: true)
    
    }
    
    func shareBtn(){
        self.bgView = UIView(frame: CGRectMake(0,400,screenWidth,screenHeight-300-64))
        bgView?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(bgView!)
        
        let shareLabel = UILabel.createLabel("分享到", font:UIFont.boldSystemFontOfSize(20), alignment: .Center, textColor: UIColor.blackColor())
        shareLabel.frame = CGRectMake(screenWidth/2-50, 0, 100, 40)
        bgView?.addSubview(shareLabel)
        
        let titleArray = ["微信朋友圈","微信好友","微博","QQ空间","QQ好友","复制链接"]
        let imageArray = ["朋友圈","微信","微博","qqz","qqp","链接"]
        //wxid_sss8qq4zalrv22   ecc02c77
        let w: CGFloat = 60
        let h: CGFloat = 60
        let y: CGFloat = 18
        let spaceX: CGFloat = 50
        let spacey: CGFloat = 20
        for i in 0..<titleArray.count {
            let row = i/3
            let col = i%3
            let btn = UIButton.createBtn(imageArray[i], title: nil, target: self, action: #selector(shareAction(_:)))
            
            btn.frame = CGRectMake(CGFloat(col)*(w+spaceX)+spaceX, CGFloat(row)*(h+spacey)+spacey+y, w, h)
            btn.tag = 200+i
            bgView?.addSubview(btn)
            
            let label = UILabel.createLabel(titleArray[i], font: UIFont.systemFontOfSize(12), alignment: .Center, textColor: UIColor.blackColor())
            label.frame = CGRectMake(CGFloat(col)*(w+spaceX)+spaceX, CGFloat(row)*(h+spacey)+spacey+w+y, w, 20)
            bgView?.addSubview(label)
        }
        
        let cancelBtn = UIButton.createBtn(nil, title: "取消", target: self, action: #selector(cancelAction))
        cancelBtn.frame = CGRectMake(screenWidth/2-50, 220, 100, 40)
        cancelBtn.backgroundColor = UIColor.grayColor()
        cancelBtn.layer.cornerRadius = 5
        cancelBtn.layer.masksToBounds = true
        
        bgView?.addSubview(cancelBtn)
        
        
    }
    
    func cancelAction(){
        self.bgView?.removeFromSuperview()
        self.bgView = nil
    }
    func shareAction(btn: UIButton){
        
    
    }
    
    
    
    func nextBtn(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func creataWebView(){
        automaticallyAdjustsScrollViewInsets = false
        webView = UIWebView(frame: CGRectMake(0,64,screenWidth,screenHeight-64))
       //http://api.bohejiaju.com/v1/posts/4545
        //url": "http://bohejiaju.liwushuo.com/posts/4545
        let d = Int(id!)
        var string = ""
        if items {
            string = String(format: "http://bohejiaju.liwushuo.com/items/%ld", d)
        }else {
            string = String(format: "http://bohejiaju.liwushuo.com/posts/%ld", d)
        }
        let urlString = NSURL(string: string as String)
        let repuest = NSURLRequest(URL: urlString!)
        webView?.loadRequest(repuest)
        webView?.delegate = self
        view.addSubview(webView!)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}





