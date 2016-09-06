//
//  CatetoryViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit


class CatetoryViewController: BaseViewController,SpecialCellDelegate {
    var tbView: UITableView?
    
    var model: CategotyModel?
    var specialModel: SpecialMOdel?
    
    var clickClosur: CellClosure?
    var specialView: SpecialCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNav()
        downloderData()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    func addNav(){
        addNavTitle("分类")
        addNavBtn(nil, bgImage: "search", target: self, action: #selector(searchAction), isLeft: false)
    }
    
    func searchAction(){
        let searchCtrl = SearchViewController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchCtrl, animated: true)
        self.hidesBottomBarWhenPushed = false

    }
    
    func createTabView(){
        self.automaticallyAdjustsScrollViewInsets = false
        tbView = UITableView(frame: CGRectMake(0, 64, screenWidth, screenHeight-64-44), style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.separatorStyle = .None
        view.addSubview(tbView!)
    
    }
    
    
    
    //http://api.bohejiaju.com/v1/collections?limit=20&offset=0
    func downloderData(){
    
        let urlString = "http://api.bohejiaju.com/v1/collections?limit=6&offset=0"
        let downloder = Downloder()
            downloder.delegate = self
            downloder.type = 103
            downloder.downloderFunc(urlString)
        
        let specialUrl = "http://api.bohejiaju.com/v1/channel_groups/all"
        let down = Downloder()
        down.delegate = self
        down.type = 104
        down.downloderFunc(specialUrl)
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension CatetoryViewController: DownloderDelegate{
    func downloder(downloder: Downloder, error: NSError) {
        print(error)
    }

    func downloder(downloder: Downloder, data: NSData?) {
        if downloder.type == 103 {
            let cateModel = CategotyModel.parseModel(data!)
        
            dispatch_async(dispatch_get_main_queue()) {
                self.model = cateModel
                self.createTabView()
                self.tbView?.reloadData()
            }
        }else if downloder.type == 104 {
           self.specialModel  =  SpecialMOdel.parseModel(data!)
            dispatch_async(dispatch_get_main_queue(), {
                self.tbView?.reloadData()
               
            })
        }
    }
}


extension CatetoryViewController:UITableViewDelegate,UITableViewDataSource{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowNum = 1
        
        if specialModel?.data?.channel_groups?.count > 0 {
            rowNum += 1
        }
        
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       if indexPath.section == 0{
            let cellId = "specialCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? SpecialCell
            
            if cell == nil{
                cell = NSBundle.mainBundle().loadNibNamed("SpecialCell", owner: nil, options: nil).last as? SpecialCell
            }
            
            cell?.collectionsModel = model?.data?.collections
            cell?.selectionStyle = .None
        
                
                
            cell?.delegate = self
            return cell!
       }else if indexPath.section == 1 {
        
            let cellId = "placeCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? PlaceCell
            if cell == nil{
                cell = NSBundle.mainBundle().loadNibNamed("PlaceCell", owner: nil, options: nil).last as? PlaceCell
            }
        
            cell?.channelsArray = (specialModel?.data?.channel_groups![0])?.channels
            cell?.selectionStyle = .None
            cell?.delegate = self
            return cell!
        
       }else{
            let cellId = "catetoryCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CaretoryCell
            if cell == nil {
                cell = NSBundle.mainBundle().loadNibNamed("CaretoryCell", owner: nil, options: nil).last as? CaretoryCell
            }
        
            cell?.channelModel = (specialModel?.data?.channel_groups![1])?.channels
            cell?.selectionStyle = .None
            cell?.deletate = self
            return cell!
        
        }
        
        
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat = 0
        if indexPath.section == 0{
            height =  180
        }else if indexPath.section == 1{
            height = 250
        }else if indexPath.section == 2 {
            height = 150
        }
        return height
    }

}

extension CatetoryViewController {
    func specialId(id: Int?) {
        if id == nil {
            self.hidesBottomBarWhenPushed = true
            let allCtrl = AllTitleViewController()
            self.navigationController?.pushViewController(allCtrl, animated: true)
            self.hidesBottomBarWhenPushed = false
        }else{
            let scroDetaCtrl = ScroDetailViewController()
            scroDetaCtrl.id = id
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(scroDetaCtrl, animated: true)
            self.hidesBottomBarWhenPushed = false
        
        }
    }

}


//地点的代理方法
extension CatetoryViewController: PlaceCellDelegate{

    func placeId(id:Int,navTitle: String?) {
        let scroDetaCtrl = CategoryDetailViewController()
        scroDetaCtrl.id = id
        scroDetaCtrl.navTitle = navTitle
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(scroDetaCtrl, animated: true)
        self.hidesBottomBarWhenPushed = false
    }

}

extension CatetoryViewController: CaretoryCellDelegate {
    func caretouyId(id: Int, title: String) {
        let scroCtrl = CategoryDetailViewController()
        scroCtrl.id = id
        scroCtrl.navTitle = title
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(scroCtrl, animated: true)
        self.hidesBottomBarWhenPushed = false
    }

}








