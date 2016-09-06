//
//  HeaderView.swift
//  Mint
//
//  Created by qianfeng on 16/8/25.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    var commonbtn: UIButton?
    var titlebtn: UIButton?
    var lineView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        let bgView = UIView.createView()
        bgView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
        bgView.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        self.addSubview(bgView)
        
        self.commonbtn = UIButton.createBtn(nil, title: "喜欢的专题", target: self, action: #selector(commonAction(_:)))
            commonbtn?.frame = CGRectMake(0, 0, (bounds.size.width)/2, bounds.size.height)
            commonbtn?.setTitleColor(UIColor.blackColor(), forState: .Normal)
            commonbtn?.layer.borderWidth = 1
            commonbtn?.layer.borderColor = UIColor.brownColor().CGColor
            commonbtn?.tag = 300
        bgView.addSubview(commonbtn!)
        
        self.titlebtn = UIButton.createBtn(nil, title: "喜欢的商品", target: self, action: #selector(titleAction(_:)))
            titlebtn?.setTitleColor(UIColor.blackColor(), forState: .Normal)
            titlebtn?.frame = CGRectMake((bounds.size.width)/2, 0, (bounds.size.width)/2, bounds.size.height)
            titlebtn?.layer.borderWidth = 1
            titlebtn?.layer.borderColor = UIColor.brownColor().CGColor
            titlebtn?.tag = 301
        bgView.addSubview(titlebtn!)
        
        // 横线
        lineView = UIView.createView()
        lineView!.backgroundColor = UIColor.greenColor()
        lineView!.frame = CGRectMake(0, 57, screenWidth/2, 3)
         bgView.addSubview(lineView!)
        
        
    }
    func commonAction(btn: UIButton){
        let index = btn.tag - 300
        lineView?.frame.origin.x = (lineView?.bounds.width)!*CGFloat(index)
    }
    
    func titleAction(btn: UIButton){
        let index = btn.tag - 300
        lineView?.frame.origin.x = (lineView?.bounds.width)!*CGFloat(index)+2
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
