//
//  BaseViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func addNavTitle(title:String){
        let titleLabel = UILabel.createLabel(title, font: UIFont.boldSystemFontOfSize(20), alignment: .Center, textColor: UIColor.brownColor())
        titleLabel.frame = CGRectMake(0,0, 20, 20)
        navigationItem.titleView = titleLabel
    }

    func addNavBtn(title:String?,bgImage:String?,target:AnyObject,action:Selector,isLeft:Bool){
       let btn = UIButton.createBtn(bgImage, title: title, target: target, action: action)
        btn.frame = CGRectMake(0, 4, 30, 40)
        
        let barBtn = UIBarButtonItem(customView: btn)
        if isLeft{
            navigationItem.leftBarButtonItem = barBtn
        }else{
            navigationItem.rightBarButtonItem = barBtn
        }
    
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
