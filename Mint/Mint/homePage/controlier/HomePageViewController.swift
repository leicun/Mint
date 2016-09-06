//
//  HomePageViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import XWSwiftRefresh
class HomePageViewController: BaseViewController {

    var downlodeNum:Bool = true
    var lineView: UIView?
    //选中的序号
    var selectedIndex: Int = 0
    //标题滚动视图
    var scrollView: UIScrollView?
    
    var titleModel: TitleModel?
    
     //首页滚动视图
    var pageScroll: UIScrollView?
    //公有的视图
    var cateView: CategoryView?
    
    //存刷新数组
    var dataArray: NSArray?
   
    private var recommendView: HomePageView?
    //存放标题的id
    var idArray: NSMutableArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //首页选择的数据
        downloaderChooseData()
        addNav()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    //detailed
    // 设置 标题视图
    func createTitleView(){
        lineView = UIView.createView()
        lineView?.frame = CGRectMake(0,100 , 50, 2)
        lineView?.backgroundColor = UIColor.greenColor()
        view.addSubview(lineView!)
        scrollView = UIScrollView(frame: CGRectMake(0,64,screenWidth-70,36))
        
        scrollView?.pagingEnabled = true
        scrollView?.bounces = false
        view.addSubview(scrollView!)
        let cnt = titleModel?.data?.channels?.count
        let nameArray = titleModel?.data?.channels
        let w: CGFloat = 50
        let h: CGFloat = 20
        let spaceY: CGFloat = 5
        self.idArray = NSMutableArray()
        
        for i in 0..<cnt! {
            let btn = UIButton(frame: CGRectMake(CGFloat(i)*w,spaceY,w,h))
            btn.setTitle(nameArray![i].name!, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            btn.tag = 300+i
            
            btn.addTarget(self, action: #selector(titleAction(_:)), forControlEvents: .TouchUpInside)
            self.idArray?.addObject((nameArray![i].id)!)
            scrollView?.addSubview(btn)
            
        }

        
        let btn = UIButton(type: .System)
            btn.frame = CGRectMake(screenWidth-70, 64, 70, 36)
            btn.setBackgroundImage(UIImage(named: "Unknown128"), forState: .Normal)
        btn.addTarget(self, action: #selector(expandBtn), forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.contentSize = CGSizeMake(CGFloat(cnt!)*52, 36)
    }
    
    func expandBtn(){}
    //
    func titleAction(btn: UIButton){
        
       selectedIndex = btn.tag - 300
        
        lineView?.frame.origin.x = (lineView?.bounds.width)!*CGFloat(selectedIndex)
        self.pageScroll?.setContentOffset(CGPointMake(CGFloat(screenWidth * CGFloat( selectedIndex)), 0), animated: true)
    }
    
    //首页滚动视图
    func createPageScrollView(){
        self.automaticallyAdjustsScrollViewInsets = false
        pageScroll = UIScrollView()
        pageScroll?.showsHorizontalScrollIndicator = false
        pageScroll?.delegate = self
        self.view.addSubview(pageScroll!)
        
        pageScroll?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(102, 0,49, 0))
        })
        
        let containerView = UIView.createView()
        pageScroll?.addSubview(containerView)
        
        containerView.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo((self?.pageScroll)!)
            make.height.equalTo((self?.pageScroll)!)
        }
        
        recommendView = HomePageView()
        recommendView?.delegate = self
        containerView.addSubview(recommendView!)
        
        recommendView?.snp_makeConstraints(closure: {
            (make) in
            make.top.bottom.equalTo(containerView)
            make.left.equalTo(containerView)
            make.width.equalTo(screenWidth)
            })
        
        var lastView: UIView? = nil
        let cnt = (titleModel?.data?.channels?.count)!-1
        for i in 0..<cnt {
                
                cateView = CategoryView()
                cateView!.delegate = self
                cateView?.tag = 300+i
                containerView.addSubview(cateView!)
                
                cateView!.snp_makeConstraints(closure: { (make) in
                    
                    make.top.bottom.equalTo(containerView)
                    make.width.equalTo(screenWidth)
                    if i == 0{
                       make.left.equalTo((recommendView?.snp_right)!)
                    }else {
                        make.left.equalTo((lastView?.snp_right)!)
                    }
                })

                lastView = cateView
            }
            
            containerView.snp_makeConstraints { (make) in
                make.right.equalTo((lastView?.snp_right)!)
            }
        pageScroll?.bounces = false
        pageScroll?.pagingEnabled = true
       
    }
    
    func header(){
        if self.recommendView!.tbView?.headerView == nil{
            self.recommendView!.tbView?.headerView = XWRefreshNormalHeader(target: self, action: #selector(headerAction))
        }
    }
    
    func headerAction(){
        self.page = 0
        downloderData()
    }

    func footer(){
        
        if self.recommendView?.tbView?.footerView == nil{
            self.recommendView?.tbView?.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(addFooterView))
            }
    }
    
    func addFooterView (){
        if self.downlodeNum == true{
            self.page += 20
            downloderData()
            
        }
    }
    //首页选择的数据
    func downloaderChooseData(){
        let chooseString = String(format: "http://api.bohejiaju.com/v2/channels/preset?gender=1&generation=4")
        let downloderChoose = Downloder()
        downloderChoose.type = 100
        downloderChoose.delegate = self
        downloderChoose.downloderFunc(chooseString)
    }
    
    
    //小滚动视图和表格数据
    func downloderData(){
        let urlString = "http://api.bohejiaju.com/v1/banners?channel=iOS"
        let dowloder = Downloder()
        dowloder.delegate = self
        dowloder.type = 101
        dowloder.downloderFunc(urlString)
        
        //表格视图
        //http://api.bohejiaju.com/v1/channels/4/items?gender=1&generation=1&limit=20&offset=0
        let  choicendssUrl = String(format:"http://api.bohejiaju.com/v1/channels/10/items?gender=2&generation=4&limit=20&offset=%ld",(self.page))
        let choicendssDown = Downloder()
        choicendssDown.delegate = self
        choicendssDown.type = 102
        choicendssDown.downloderFunc(choicendssUrl)
        

    }
    
    //下载大滚动视图数据
    func downloaderScrollViewData(){
        let cnt = (self.idArray?.count)!-1
        for i in 0..<cnt {
            let scrollString = String(format: "http://api.bohejiaju.com/v1/channels/%ld/items?limit=20&offset=%d", Int(self.idArray![i+1] as! NSNumber),self.page)
            let downloderArray = Downloder()
            downloderArray.type = 200+i
            downloderArray.delegate = self
            downloderArray.downloderFunc(scrollString)
        }
    
    }
    
    func showScrollDetail(){
        recommendView?.clickClosure = {
            [weak self]
            (title:String?,id:Int?) in
            let scrollCtrl = ScroDetailViewController()
            scrollCtrl.id = id
            self?.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(scrollCtrl, animated: true)
            self?.hidesBottomBarWhenPushed = false
        }
    }
    
    
    
    //滚动视图的刷新
    func footerScroll(){
        if self.cateView?.tbView?.footerView == nil{
            self.cateView?.tbView?.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(refreshScroll))
        }
    }
    func refreshScroll(){
        self.page += 20
       
        downloaderScrollViewData()
    }
    
    func headerScroll(){
       
        if self.cateView?.tbView?.headerView == nil {
            self.cateView?.tbView?.headerView = XWRefreshNormalHeader(target: self, action: #selector(refreshScrollHeader))
        }
    }
    func refreshScrollHeader(){
        self.page = 0
        downloaderScrollViewData()
    }
    
    func addNav(){
        addNavTitle("薄荷家居")
        addNavBtn(nil, bgImage: "search@3x", target: self, action: #selector(searchAction), isLeft: false)
    }
    
    func searchAction(){
        let searchCtrl = SearchViewController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchCtrl, animated: true)
        self.hidesBottomBarWhenPushed = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomePageViewController:DownloderDelegate{
    func downloder(downloder: Downloder, error: NSError) {
        print(error)
    }
    
    func downloder(downloder: Downloder, data: NSData?) {
        //导航滚动数据
        if downloder.type == 100{
            if let jsonData = data {
                let model =  TitleModel.parseModel(jsonData)
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.titleModel = model
                    self.createTitleView()
                    
                     //滚动视图数据和表格视图
                    self.downloderData()
                    
                    //整个页面滑动
                    self.downloaderScrollViewData()
                    self.createPageScrollView()
                })
            }

        }else if downloder.type == 101{
            //下载小滚动视图数据
            if let jsonData = data{
                let model = ScrollModel.parseModel(jsonData)
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    self?.recommendView?.model = model
                    self?.showScrollDetail()
                    })
            }
        }else if downloder.type == 102 {
            //下载表格数据
            if let jsonData = data{
                let model = ChoicenessModel.parseModel(jsonData)
                
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    if model.data?.items?.count == 0{
                        self?.downlodeNum = false
                    }else{
                        self!.recommendView?.choiceneModel = model
                    }
                    
                    self!.header()
                    self!.footer()
                    self!.recommendView!.tbView?.footerView?.endRefreshing()
                    self!.recommendView!.tbView?.headerView?.endRefreshing()
                    
                    })
                
            }
        }else {
            if let jsonData = data {
                for i in 0..<(self.idArray?.count)!-1{
                    if  downloder.type == 200+i {
                        let model = ChoicenessModel.parseModel(jsonData)
                        dispatch_async(dispatch_get_main_queue(), {
                            [weak self] in
                           
                                let subView = self!.pageScroll?.viewWithTag(300+i)
                                if ((subView?.isKindOfClass(CategoryView.self)) == true) {
                                    let cateView = subView as! CategoryView
                                    cateView.categotyDetailModel = model
                                   
                                }
                            self!.footerScroll()
                            self!.headerScroll()

                            
                                self!.cateView!.tbView?.footerView?.endRefreshing()
                                self!.cateView!.tbView?.headerView?.endRefreshing()
                            
                        })
                    }
                }
               
            }
        }
    }
}

extension HomePageViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        self.selectedIndex = index
        lineView?.frame.origin.x = (lineView?.bounds.width)!*CGFloat(selectedIndex)
       
    }
}


extension HomePageViewController: HomePageViewDelegate {
    func homePageTabelId(id: Int) {
        let singleCtrl = SingleDetailViewController()
        singleCtrl.id = id
        singleCtrl.items = false
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(singleCtrl, animated: true)
        self.hidesBottomBarWhenPushed = false
    }

}


extension HomePageViewController: CategoryViewDelegate {
    func categoryDetailId(id: Int, items: Bool) {
        let singCtrl = SingleDetailViewController()
        singCtrl.items = items
        singCtrl.id = id
        
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(singCtrl, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
}












