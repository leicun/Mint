//
//  AllTitleViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/30.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class AllTitleViewController: BaseViewController {

    var tbView: UITableView?
    var allModel: AllModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.downloaderData()
        self.addNavTitle("全部专题")
        self.addNavBtn(nil, bgImage: "left", target: self, action: #selector(returnBtn), isLeft: true)
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    func returnBtn(){
        self.navigationController?.popViewControllerAnimated(true)
    
    }
    
    func downloaderData(){
        let urlString = "http://api.bohejiaju.com/v1/collections?limit=20&offset=0"
        let download = Downloder()
        download.delegate = self
        download.downloderFunc(urlString)
    
    
    }
    
    func createTableView(){
        self.automaticallyAdjustsScrollViewInsets = false
        self.tbView = UITableView(frame: CGRectMake(0, 64, screenWidth, screenHeight-64), style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.separatorStyle = .None
        self.view.addSubview(self.tbView!)
    
    
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension AllTitleViewController: DownloderDelegate {
    func downloder(downloder: Downloder, error: NSError) {
        print(error)
    }
    
    func downloder(downloder: Downloder, data: NSData?) {
        if let jsonData = data {
            let model = AllModel.parseModel(jsonData)
            dispatch_async(dispatch_get_main_queue(), { 
                [weak self] in
                self?.allModel = model
                self!.tbView?.reloadData()
                self!.createTableView()
            })
        }
    }

}


extension AllTitleViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.allModel?.data?.collections?.count)!
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "allTitleCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? AllTitleCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("AllTitleCell", owner: nil, options: nil).last as? AllTitleCell
        }
        let model = self.allModel?.data?.collections![indexPath.row]
        cell?.configModle(model!)
        cell?.selectionStyle = .None
        return cell!
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let scroCtrl = ScroDetailViewController()
        let id  = self.allModel?.data?.collections![indexPath.row].id
        scroCtrl.id = Int(id!)
        self.navigationController?.pushViewController(scroCtrl, animated: true)
        
    }
    
}







