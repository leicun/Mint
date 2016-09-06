
//
//  CactegoryView.swift
//  Mint
//
//  Created by qianfeng on 16/8/28.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

protocol CategoryViewDelegate: NSObjectProtocol {
    func categoryDetailId(id:Int,items:Bool)
}

class CategoryView: UIView {
    
    var delegate:CategoryViewDelegate?
    
    var tbView: UITableView?
    var categotyDetailModel: ChoicenessModel? {
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

extension CategoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numRow = 0
        if categotyDetailModel != nil {
            numRow = (categotyDetailModel?.data?.items?.count)!
            
        }
        
        return numRow

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        let choicModel = categotyDetailModel?.data?.items
        if categotyDetailModel?.data?.items?.count > 0 {
            cell = ChoicenessCell.createCell(tableView, indexPath: indexPath, model: choicModel!)
        }
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return  180
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let items = false
        let id = Int((categotyDetailModel?.data?.items![indexPath.row].id)!)
        self.delegate?.categoryDetailId(id, items: items)
    }
}











