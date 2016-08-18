//
//  UILabel.swift
//  Mint
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

extension UILabel{
    
    class func createLabel(text:String?,font:UIFont?,alignment:NSTextAlignment?,textColor:UIColor?)->UILabel{
        let label = UILabel()
        if let labelText = text{
            label.text = labelText
        
        }
        
        if let textFont = font{
            label.font = textFont
        }
        
        if let textAlignment = alignment{
            label.textAlignment = textAlignment
        
        }
        
        if  let labelColor = textColor{
            label.textColor = labelColor
        }
        
    
        return label
    }


}











