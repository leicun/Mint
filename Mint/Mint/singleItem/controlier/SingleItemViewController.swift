//
//  singleItemViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import XWSwiftRefresh

class SingleItemViewController: UIViewController,DownloderDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var page: Int = 0
   //搜索的内容
    var searchText: String?
    
    //判断是单品页面还是搜索页面
    var searchTrue: Bool = false
    var dataArray = NSMutableArray()
    
    var collView: UICollectionView?
    
    var model: SingIeitmModel?
    //搜索结果model
    var commendModel: CommendModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addNav()
        downloderData()
       self.view.backgroundColor = UIColor.whiteColor()
        
        
        }
    
    func addNav(){
        if searchTrue {
            let labdel = UILabel.createLabel("\(self.searchText!)", font: UIFont.boldSystemFontOfSize(23), alignment: .Center, textColor: UIColor.brownColor())
            labdel.frame = CGRectMake(0, 0, 50, 50)
            navigationItem.titleView = labdel
            
        }else{
             let labdel = UILabel.createLabel("单品", font: UIFont.boldSystemFontOfSize(23), alignment: .Center, textColor: UIColor.brownColor())
            labdel.frame = CGRectMake(0, 0, 50, 50)
            navigationItem.titleView = labdel
        }
        
      
        
        
        
    }

    func downloderData(){
        var urlString = ""
        if self.searchTrue {
            let url = NSURL(string: (self.searchText?.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()))!)
            urlString = String(format: "http://api.bohejiaju.com/v1/search/item?keyword=%@&limit=20&offset=0&sort=", url!)
        }else {
            urlString = String(format: "http://api.bohejiaju.com/v2/items?gender=1&generation=4&limit=20&offset=%ld", self.page)
        }
        
        let downloader = Downloder()
        downloader.delegate = self
        downloader.downloderFunc(urlString)
    }
    
    func header(){
        if collView?.headerView == nil{
            collView?.headerView = XWRefreshNormalHeader(target: self, action: #selector(headerAction))
        }
    }
    
    func headerAction(){
        self.page = 0
        downloderData()
    }
    
    func footer(){
        if collView?.footerView == nil{
            collView?.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(footerAction))
        }
    }
    
    func footerAction(){
            self.page += 20

            downloderData()
        
    }

    func createcollView(){
        automaticallyAdjustsScrollViewInsets = false
        let layout = UICollectionViewFlowLayout()
        collView = UICollectionView(frame: CGRectMake(0, 64, screenWidth, screenHeight-64), collectionViewLayout: layout)
        collView?.delegate = self
        collView?.dataSource = self
        
        let nib  = UINib(nibName:"SingViewCell", bundle: nil)
        collView?.registerNib(nib, forCellWithReuseIdentifier: "singViewId")
        
        collView?.backgroundColor = UIColor.whiteColor()
        view.addSubview(collView!)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SingleItemViewController{
    
    func downloder(downloder: Downloder, error: NSError) {
        print(error)
    }
    
    func downloder(downloder: Downloder, data: NSData?) {
        if self.searchTrue {
            
            if let jsonData = data{
                let model = CommendModel.parseModel(jsonData)
                dispatch_async(dispatch_get_main_queue(), {
                    self.commendModel = model
                    if (self.commendModel?.data?.paging?.next_url) == nil {
                        UIAlert.showAlert("没有找到相关内容", viewController: self, alertClosure: { (returnView) in
                            self.navigationController?.popViewControllerAnimated(true)
                        })
                        }
                    if self.commendModel != nil {
                        self.createcollView()
                    }
                    self.header()
                    self.footer()
                    self.collView?.footerView?.endRefreshing()
                    self.collView?.headerView?.endRefreshing()
                })
            }
           
        }else {
            if let jsonData = data{
                let model = SingIeitmModel.parseModel(jsonData)
                dispatch_async(dispatch_get_main_queue(), {
                    self.model = model
                    if self.model != nil {
                        self.createcollView()
                    }
                    self.header()
                    self.footer()
                    self.collView?.footerView?.endRefreshing()
                    self.collView?.headerView?.endRefreshing()
                })
            }

        
        }
    }
}

extension SingleItemViewController{

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchTrue {
            return (self.commendModel?.data?.items?.count)!
        }else{
            return (self.model?.data?.items?.count)!
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("singViewId", forIndexPath: indexPath) as! SingViewCell
    
        if searchTrue {
                let model = self.commendModel?.data?.items![indexPath.row]
                cell.searchModel(model!)
            
        }else{
            
            let model = ((self.model?.data?.items![indexPath.row])! as ItemsDataModel).data
            cell.configModel(model!)
        }
            return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
       func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(170, 300)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
            let singleCtrl = SingleDetailViewController()
            if searchTrue {
                singleCtrl.id = self.commendModel?.data?.items![indexPath.row].id
            }else {
                singleCtrl.id = ((self.model!.data!.items![indexPath.item])).data?.id
            }
        
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(singleCtrl, animated: true)
            self.hidesBottomBarWhenPushed = false
    }
    


}










