//
//  UIButton.swift
//  Mint
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

extension UIButton{

   class func createBtn(bgImage:String?,title:String?,target:AnyObject?,action:Selector?)->UIButton{
        let btn = UIButton(type: .Custom)
        if let btnImage = bgImage{
            btn.setBackgroundImage(UIImage(named: btnImage), forState: .Normal)
        }
        if let btnTitle = title{
            btn.setTitle(btnTitle, forState: .Normal)
        }
        if let btnTarget = target{
            btn.addTarget(btnTarget, action: action!, forControlEvents: .TouchUpInside)
        }
        return btn
    }
}
