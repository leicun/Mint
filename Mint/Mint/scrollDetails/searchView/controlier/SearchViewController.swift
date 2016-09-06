//
//  SearchViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/28.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    var textField: UITextField?
    //大家都在搜 model
    var scarchModel: SearchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        createNav()
        downloadData()
        
        
    }

    func createNav(){
        addNavBtn(nil, bgImage: "left", target: self, action: #selector(returnBtn), isLeft: true)
        addNavBtn("搜索", bgImage: nil, target: self, action: #selector(searchBtn), isLeft: false)
        textField = UITextField(frame: CGRectMake(30,4,screenWidth-30-40,44-4*2))
        textField?.borderStyle = .RoundedRect
        textField?.placeholder = "请输入你要找的商品"
        textField?.clearButtonMode = .Always
//        let image = UIImage(named: "search")
//        let imageView = UIImageView(frame: CGRectMake(0, 10, 30, 30))
//        imageView.image = image
//        textField?.leftView = imageView
//        textField?.leftViewMode = .Always
        navigationItem.titleView = textField
        
        let label = UILabel.createLabel("大家都在搜", font: UIFont.systemFontOfSize(18), alignment: .Center, textColor: UIColor.blackColor())
        label.frame = CGRectMake(20, 100, 100, 20)
        self.view.addSubview(label)
        }
        
        
    
    func searchBtn(){
        if self.textField?.text == "" {
            
            UIAlert.showAlert("搜索内容为空,请输入搜索内容", viewController: self, alertClosure: nil)
        
        }else{
            let singleCtrl = SingleItemViewController()
            singleCtrl.searchText = self.textField?.text
            singleCtrl.searchTrue = true
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(singleCtrl, animated: true)
        }
        
        
        
    }
    func greatSearch(){
        
    }
    
    
    //下载大家都来搜数据
    func downloadData(){
        let urlString = "http://api.bohejiaju.com/v1/search/hot_words"
        let download = Downloder()
        download.delegate = self
        download.downloderFunc(urlString)
    
    }
    
    //显示大家都再搜表格
    
    func allView() {
      
        if self.scarchModel != nil {
            let cut = self.scarchModel?.data?.hot_words?.count
            
            let spaceX: CGFloat = 10
            let spaceY: CGFloat = 10
            let colNum = 4
            let btnH: CGFloat = 40
            let btnW = (screenWidth-spaceX*CGFloat(colNum+1))/CGFloat(colNum)
            let y:CGFloat = 40
            for i in 0..<cut! {
                let row = i/4
                let col = i%4
                let btn = UIButton.createBtn(nil, title: "\((self.scarchModel?.data?.hot_words![i])!)", target: self, action: #selector(scarchBtn(_:)))
                btn.frame = CGRectMake(spaceX+CGFloat(col)*(btnW+spaceX), y+2*(btnH+spaceY)+CGFloat(row)*(btnH+spaceY), btnW, btnH)
                btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                btn.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
                btn.tag = 300+i
                self.view.addSubview(btn)
            }
        }
    }
    
    
    
    func scarchBtn(btn: UIButton) {
       let btnText = btn.titleLabel?.text
        let singleCtrl = SingleItemViewController()
        singleCtrl.searchText = btnText
        singleCtrl.searchTrue = true
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(singleCtrl, animated: true)
    
    }
    
    func returnBtn(){
        self.navigationController?.popViewControllerAnimated(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}





extension SearchViewController: DownloderDelegate {
    func downloder(downloder: Downloder, error: NSError) {
        print(error)
    }
    
    func downloder(downloder: Downloder, data: NSData?) {
        if let jsonData = data {
           let model = SearchModel.parseModel(jsonData)
        
            dispatch_async(dispatch_get_main_queue(), { 
                self.scarchModel = model
                self.allView()
            })
        }
    }

}









