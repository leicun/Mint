//
//  HomePageViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class HomePageViewController: BaseViewController {

    private var recommendView:HomePageView?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        downloderData()
        createHomePageView()
        addNav()
    }
    
    func createHomePageView(){
        self.automaticallyAdjustsScrollViewInsets = false
        recommendView = HomePageView()
        self.view.addSubview(recommendView!)
        recommendView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        })
    
    }
    
    func downloderData(){
        let urlString = "http://api.bohejiaju.com/v1/banners?channel=iOS"
        let dowloder = Downloder()
        dowloder.delegate = self
        dowloder.downloderFunc(urlString)
    }
    
    func addNav(){
        addNavTitle("薄荷家居")
        
        addNavBtn(nil, bgImage: "search@3x", target: self, action: #selector(searchAction), isLeft: false)
    
    }
    
    func searchAction(){
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomePageViewController:DownloderDelegate{
    func downloder(downloder: Downloder, error: NSError) {
        print(error)
    }
    
    func downloder(downloder: Downloder, data: NSData?) {
        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
       // print(json)
        if let jsonData = data{
            
            let model = ScrollModel.parseModel(jsonData)
            dispatch_async(dispatch_get_main_queue(), { 
                [weak self] in
                self?.recommendView?.model = model
            })
        }
        
        
    }

}















