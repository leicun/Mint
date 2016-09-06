//
//  BaseViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
    var page:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    func addNavTitle(title:String){
        let titleLabel = UILabel.createLabel(title, font: UIFont.boldSystemFontOfSize(23), alignment: .Center, textColor: UIColor.brownColor())
        titleLabel.frame = CGRectMake(0,0, 20, 20)
        titleLabel.textAlignment = .Center
        navigationItem.titleView = titleLabel
        //navigationController?.navigationBar.barTintColor = UIColor.greenColor()
    }

    func addNavBtn(title:String?,bgImage:String?,target:AnyObject,action:Selector,isLeft:Bool){
       let btn = UIButton.createBtn(bgImage, title: title, target: target, action: action)
        
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        let barBtn = UIBarButtonItem(customView: btn)
        if isLeft{
            btn.frame = CGRectMake(0, 4, 30, 30)
            navigationItem.leftBarButtonItem = barBtn
        }else{
            btn.frame = CGRectMake(0, 4, 40, 30)
            navigationItem.rightBarButtonItem = barBtn
        }
    
    }
}

