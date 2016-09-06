//
//  MoreViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/31.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
public let imageArray = "imageArray"
public let titlArray = "titleArray"
public let subTitleArray = "subTitleArray"

class MoreViewController: BaseViewController {
    lazy var dataArray = NSMutableArray()
    var tbView: UITableView?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.createData()
        self.creareTableView()
        self.addNavTitle("更多")
        self.addNavBtn(nil
            , bgImage: "left", target: self, action: #selector(returnBtn), isLeft: true)
    }

    func returnBtn(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func createData(){
        var dict1 = Dictionary<String,AnyObject>()
        dict1[imageArray] = ["推荐","意见反馈","投稿"]
        dict1[titlArray] = ["推荐给好友","意见反馈","我要投稿"]
        self.dataArray.addObject(dict1)
        
        var dict2 = Dictionary<String,AnyObject>()
        dict2[imageArray] = ["我的身份","消息推送","更新","删除"]
        dict2[titlArray] = ["我的身份","消息推送","检查更新","清除缓存"]
        dict2[subTitleArray] = ["男生+职场新人","","",""]
        self.dataArray.addObject(dict2)
    
    }
    
    
    func creareTableView(){
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tbView = UITableView(frame: CGRectMake(0, 64, screenWidth, screenHeight-64), style: .Grouped)
        tbView?.delegate = self
        tbView?.dataSource = self
        self.view.addSubview(self.tbView!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MoreViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dict = self.dataArray[section] as! Dictionary<String,AnyObject>
        
        let titleArray = dict[titlArray] as! Array<String>
        
        return titleArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellId)
        }
        
        let dict = self.dataArray[indexPath.section] as! Dictionary<String,AnyObject>
        
        let titleArray = dict[titlArray] as! Array<String>
        cell?.textLabel?.text = titleArray[indexPath.row]
        
        if dict.keys.contains(imageArray) {
            let imgArray = dict[imageArray] as! Array<String>
            let imageName = imgArray[indexPath.row]
            cell?.imageView?.image = UIImage(named: imageName)
        }
        
        
        if dict.keys.contains(subTitleArray) {
            let subArray = dict[subTitleArray] as! Array<String>
            cell?.detailTextLabel?.text = subArray[indexPath.row]
        }else {
            cell?.detailTextLabel?.text = nil
        }
     
        return cell!
    }

}












