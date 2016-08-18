//
//  HomePageView.swift
//  Mint
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class HomePageView: UIView {

    private var tbView: UITableView?
    var model: ScrollModel?{
        didSet{
            tbView?.reloadData()
        }
    }
    
    init(){
        super.init(frame:CGRectZero)
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.separatorStyle = .None
        self.addSubview(tbView!)
        
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!)
            
        })
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HomePageView:UITableViewDelegate,UITableViewDataSource{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if section == 0{
            if model?.data?.banners?.count > 0{
                row = 1
            }
        }
        
        return row
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 0
        if indexPath.section == 0{
            if model?.data?.banners?.count > 0{
                height = 160
            }
        }
        
        return height
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0{
            if model?.data?.banners?.count > 0{
                cell = HomeScrollCell.creataeCell(tableView, atIndexPath: indexPath, withModel: model!)
            }
        }
        
        return cell
    }
    
}


















