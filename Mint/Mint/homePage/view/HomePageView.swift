//
//  HomePageView.swift
//  Mint
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit


protocol HomePageViewDelegate: NSObjectProtocol {
    func homePageTabelId(id:Int)
}

class HomePageView: UIView {
    var delegate: HomePageViewDelegate?

    var tbView: UITableView?
    var clickClosure: CellClosure?
    
    var model: ScrollModel?{
        
        didSet {
           
            tbView?.reloadData()
        }
    }
    
    var choiceneModel:ChoicenessModel?
        {
        didSet {
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
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       var rowNum = 1
        if section == 0{
            if model?.data?.banners?.count != 0{
                
                rowNum = 1
                
            }
        }else {
            if choiceneModel != nil{
                rowNum = (choiceneModel?.data?.items?.count)!
            }
        }
        
        return rowNum
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 0
        if indexPath.section == 0{
            if model?.data?.banners?.count > 0{
                height = 160
            }
        }else{
            height = 180
        }
      
        return height
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell = UITableViewCell()
      
        if indexPath.section == 0{
            
            
            if model?.data?.banners?.count > 0{
                cell = HomeScrollCell.creataeCell(tableView, atIndexPath: indexPath, withModel: model!,cellClosure: clickClosure!)
              
            }
        }else{
            let choicModel = choiceneModel?.data?.items
            if choiceneModel?.data?.items?.count > 0 {
                cell = ChoicenessCell.createCell(tableView, indexPath: indexPath, model: choicModel!)
           }
        }
        cell.selectionStyle = .None

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let id = Int((choiceneModel?.data?.items![indexPath.row].id)!)
        self.delegate?.homePageTabelId(id)
    }
    
    
    
}


















