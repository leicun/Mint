//
//  CategoryDetailViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/28.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import XWSwiftRefresh
class CategoryDetailViewController: BaseViewController {
   
    var id: Int?
    var navTitle: String?
    var cateView: CategoryView?
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        downloaderData()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    
    //刷新 加载
    func footer(){
        if self.cateView?.tbView?.footerView  == nil {
            self.cateView?.tbView?.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(footerRefresh))
        }
    }
    
    func footerRefresh(){
        self.page += 20
        downloaderData()
       
    }
    
    func header() {
       if  self.cateView?.tbView?.headerView == nil {
        self.cateView?.tbView?.headerView = XWRefreshNormalHeader(target: self, action: #selector(headerRefresh))
        }
    
    }
    
    func headerRefresh() {
        self.page = 0
        downloaderData()
    }
    
    
    func createHomePageView(){
        self.automaticallyAdjustsScrollViewInsets = false
       
        cateView = CategoryView()
        cateView?.delegate = self
        view.addSubview(cateView!)

        cateView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 0, 0))
            })
    }

    func createNav(){
        addNavTitle("\(navTitle!)")
        addNavBtn(nil, bgImage: "left", target: self, action: #selector(popbtn), isLeft: true)
    }

    func popbtn(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func downloaderData(){
       let  urlString = String(format: "http://api.bohejiaju.com/v1/channels/%d/items?limit=20&offset=%d", self.id!,self.page)
        let downloder = Downloder()
        downloder.delegate = self
        downloder.downloderFunc(urlString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CategoryDetailViewController: DownloderDelegate {
    
    func downloder(downloder: Downloder, error: NSError) {
        print(error)
    }
    func downloder(downloder: Downloder, data: NSData?) {
        if let jsonData = data {
            let mod =  ChoicenessModel.parseModel(jsonData)
            dispatch_async(dispatch_get_main_queue(), {
                self.createNav()
                self.createHomePageView()
                self.cateView?.categotyDetailModel = mod
                
                //刷新加载
                self.footer()
                self.header()
                self.cateView?.tbView?.footerView?.endRefreshing()
                self.cateView?.tbView?.headerView?.endRefreshing()
               
            })
        }
    }

}

extension CategoryDetailViewController: CategoryViewDelegate {
    func categoryDetailId(id: Int, items: Bool) {
        let singCtrl = SingleDetailViewController()
        singCtrl.items = items
        singCtrl.id = id
        
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(singCtrl, animated: true)
        self.hidesBottomBarWhenPushed = true
        
    }
    
}
