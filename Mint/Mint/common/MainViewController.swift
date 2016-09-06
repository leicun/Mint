//
//  MainViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    private var bgView:UIView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createTabBar()
    }

    
    func createTabBar(){
        var ctrlArray = [String]()
        var titleArray = [String]()
        var imageArray = [String]()
        
            ctrlArray = ["Mint.HomePageViewController","Mint.SingleItemViewController","Mint.CatetoryViewController","Mint.MyViewController"]
            titleArray = ["薄荷家居","单品","分类","我"]
            imageArray = ["主页","单品","分类","account@2x"]
        var navCtrlArray = Array<UINavigationController>()
        for i in 0..<ctrlArray.count{
            let cls = NSClassFromString(ctrlArray[i]) as! UIViewController.Type
            let ctrl = cls.init()
            ctrl.tabBarItem.title = titleArray[i]
           ctrl.tabBarItem.image = UIImage(named: imageArray[i])
            let nav = UINavigationController(rootViewController: ctrl)
            navCtrlArray.append(nav)
        }
        // self.createTabBarBtn(titleArray, image: imageArray)
        self.viewControllers = navCtrlArray
    }
    
    func createTabBarBtn(title:[String],image:[String]){
        bgView = UIView()
        bgView?.backgroundColor = UIColor.whiteColor()
        view.addSubview(self.bgView!)
        
        bgView?.snp_makeConstraints(closure: { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view.snp_bottom).offset(-49)
            make.bottom.equalTo(self.view)
        })
        
       let width = screenWidth/4.0
        for i in 0..<image.count{
           
            let btn = UIButton.createBtn(image[i], title: nil, target:
                self, action: #selector(btnAction(_:)))
            
            self.bgView?.addSubview(btn)
            
            btn.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.top.equalTo(self!.bgView!).offset(5)
                make.bottom.equalTo(self!.bgView!).offset(-15)
                make.left.equalTo(width*CGFloat(i)+30)
                make.width.equalTo(30)
            })
            
            btn.tag = 300+i
            
            
            
            let label = UILabel.createLabel(title[i], font: UIFont.systemFontOfSize(10), alignment: .Center, textColor: UIColor.blackColor())
            btn.addSubview(label)
            
            label.snp_makeConstraints(closure: { (make) in
                make.left.right.equalTo(btn)
                make.top.equalTo(btn).offset(32)
                make.height.equalTo(10)
            })
            label.tag = 400
            
            if i == 0{
            
                btn.selected = true
                label.textColor = UIColor.brownColor()
            }
            
        }
        
        
    
    }
    
    func btnAction(btn:UIButton){
    
        let lastBtn = self.view.viewWithTag(300+selectedIndex)
        if let tmpbBtn = lastBtn{
            let last  = tmpbBtn as! UIButton
            let lastView = tmpbBtn.viewWithTag(400)
            if let tmpLabel = lastView{
                let lastLabel = tmpLabel as! UILabel
                last.selected = false
                lastLabel.textColor = UIColor.grayColor()
            }
        }
        
        let curLabelView = btn.viewWithTag(400)
        if let tmpLabel = curLabelView{
            let curLabel = tmpLabel as! UILabel
            btn.selected = true
            curLabel.textColor = UIColor.brownColor()
        }
        selectedIndex = btn.tag - 300
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
