//
//  ScroDetailViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class ScroDetailViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource {

    var id: Int?
    var tabVeiw: UITableView?
    var model: ScrollDetailModel?
    
    //区分下载数据
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        downloderData()
        self.view.backgroundColor = UIColor.whiteColor()
        
        
    }
    
    
    func createNav(){
        addNavTitle("\((model?.data?.title)!)")
        addNavBtn(nil, bgImage: "left", target: self, action: #selector(clickBtn), isLeft: true)
        
    }
    
    func clickBtn(){
        self.navigationController?.popViewControllerAnimated(true)
    }

    func downloderData(){
        
        var urlString = ""
        
        urlString = String(format:"http://api.bohejiaju.com/v1/collections/%d/posts?gender=1&generation=1&limit=20&offset=0",self.id!)
      
        let downlod = Downloder()
        downlod.type = 103
        downlod.delegate = self
        downlod.downloderFunc(urlString)
    
    }
    
    func createTabelView(){
        self.automaticallyAdjustsScrollViewInsets = false
        tabVeiw = UITableView()
        tabVeiw?.delegate = self
        tabVeiw?.dataSource = self
//        tabVeiw?.snp_makeConstraints(closure: { (make) in
//            make.edges.equalTo(self.view)
//        })
        tabVeiw?.separatorStyle =  .None
        tabVeiw?.frame = CGRectMake(0, 64, screenWidth, screenHeight-64)
        self.view.addSubview(tabVeiw!)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 }


extension ScroDetailViewController: DownloderDelegate{
    func downloder(downloder: Downloder, error: NSError) {
        print(error)
    }

    func downloder(downloder: Downloder, data: NSData?) {
        if let jsonData = data {
           self.model =  ScrollDetailModel.parseModel(jsonData)
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.createNav()
            self.createTabelView()
            self.tabVeiw?.reloadData()
        }
        
    }
}

extension ScroDetailViewController {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (model?.data?.posts?.count)!
        

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "scrollDetailCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? ScrollDeatailCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("ScrollDeatailCell", owner: self, options:nil).last as? ScrollDeatailCell
        }
        let cellModel = model?.data?.posts![indexPath.row]
        
        cell?.configModel(cellModel!)
        return cell!
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let singleDetailCtrl = SingleDetailViewController()
        singleDetailCtrl.id = self.model?.data?.posts![indexPath.row].id
        singleDetailCtrl.items = false
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(singleDetailCtrl, animated: true)
        self.hidesBottomBarWhenPushed = true
    }
}











