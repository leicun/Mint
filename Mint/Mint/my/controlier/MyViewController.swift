//
//  MyViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class MyViewController: BaseViewController {

    var tbView: UITableView?
    var model: LogonRtrurnModel?
    var likeCommendityModel: LogonReturncommoditModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addNav()
        createTableView()
        self.view.backgroundColor = UIColor.whiteColor()
        
        
    }
    func addNav(){
        addNavTitle("我")
        addNavBtn("更多", bgImage: nil, target: self, action: #selector(moreBtn), isLeft: false)
    }
    //下载喜欢的商品的方法
    func downloaderLikeCommendity(){
        let urlString = "http://api.bohejiaju.com/v1/users/me/favorite_lists?limit=20&offset=0"
        let downloderLike = Downloder()
            downloderLike.delegate = self
            downloderLike.downloderFunc(urlString)
    }
    
    func moreBtn(){
        let moreCtrl = MoreViewController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(moreCtrl, animated: true)
        self.hidesBottomBarWhenPushed = false
    
    }
    
    func createTableView(){
        self.automaticallyAdjustsScrollViewInsets = false
        tbView = UITableView(frame: CGRectMake(0, 64, screenWidth, screenHeight-49), style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.separatorStyle = .None
        //tbView?.bounces = false
        view.addSubview(tbView!)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MyViewController: DownloderDelegate {
    func downloder(downloder: Downloder, error: NSError) {
        print(error)
    }
    
    func downloder(downloder: Downloder, data: NSData?) {
        if let jsonData = data {
          let model = LogonReturncommoditModel.parseModel(jsonData)
            print(model.data?.favorite_lists![0].name)
            self.likeCommendityModel = model
            dispatch_async(dispatch_get_main_queue(), { 
                self.tbView?.reloadData()
            })
        }
    }
    
    
}


extension MyViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 1
        if section == 0{
            num = 1
        }else if section == 1 {
            num = 21
        }
        return num
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cellId = "logonCellId"
            var  cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? LogonCell
            if cell == nil{
                cell = NSBundle.mainBundle().loadNibNamed("LogonCell", owner: nil, options: nil).last as? LogonCell
            }
            cell?.selectionStyle = .None
            cell?.delegate = self
            if self.model != nil {
                cell?.configModel(model!)
            }
            
            return cell!
        }else if indexPath.section == 1 {
            
        
        }
        return UITableViewCell()
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var  height: CGFloat = 50
        if indexPath.section == 0 {
            height = 200
        }
        
        return height
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView: UIView? = nil
        if section == 1{
            let tmpView = HeaderView(frame: CGRectMake(0,30,screenWidth,60))
            headerView = tmpView
        }
        
        return headerView
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height: CGFloat = 0
        if section == 1{
            height = 60
        }
        return height
    }
}

extension MyViewController: LogonCellDelegate {
    func logonBtn() {
        let logonPwdCtrl = LogonViewController()
        logonPwdCtrl.delegate = self
        self.navigationController?.pushViewController(logonPwdCtrl, animated: true)
    }

}

//接受 登录返回数据的代理方法

extension MyViewController: LogonViewControllerDelegate {
    func logonRetuenNews(model: LogonRtrurnModel) {
        self.model = model
        if self.model != nil {
            downloaderLikeCommendity()
        }
    }
}













