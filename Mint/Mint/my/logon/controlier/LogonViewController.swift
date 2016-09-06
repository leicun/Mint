//
//  LogonViewController.swift
//  Mint
//
//  Created by qianfeng on 16/8/30.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
//传递登录返回消息的代理
protocol LogonViewControllerDelegate: NSObjectProtocol {
    func logonRetuenNews(model:LogonRtrurnModel)
}
class LogonViewController: BaseViewController,LogonPwdCellDelegate {
    var tbViwe: UITableView?
    //登录密码
    var logonNum: String?
    var logonPwd: String?
    var model: LogonRtrurnModel?
    var delegate: LogonViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.createTbleView()
        createNav()
    }
    //下载登录数据
    func downloderLogonData(){
        //mobile=13693040869&password=lei1123cun
        let urlSting = "http://api.bohejiaju.com/v1/account/signin"
        
        //var params = Dictionary<String,String>
        
        let params = ["mobile":"\(self.logonNum!)","password":"\(self.logonPwd!)"]
        let downloder = PostDownloder()
        downloder.delegate = self
        downloder.postDownlod(urlSting, params: params)
        
    }
    
    
    
    func createNav(){
        self.addNavTitle("登录")
        self.addNavBtn(nil, bgImage: "left", target: self, action: #selector(deleteBtn), isLeft: true)
        self.addNavBtn("注册", bgImage: nil, target: self, action: #selector(tegisterBtn), isLeft: false)
    }
    
    func deleteBtn(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func tegisterBtn(){
        let loginCtrl = LoginViewController()
        loginCtrl.loginNavTitle = "注册"
        self.navigationController?.pushViewController(loginCtrl, animated: true)
    }
    
    
    
    func createTbleView(){
        self.automaticallyAdjustsScrollViewInsets = false
        self.tbViwe = UITableView()
        tbViwe?.frame = CGRectMake(0, 64, screenWidth, screenHeight-64)
        tbViwe?.delegate = self
        tbViwe?.dataSource = self
        tbViwe?.separatorStyle = .None
        self.view.addSubview(self.tbViwe!)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LogonViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "logonPwdCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? LogonPwdCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("LogonPwdCell", owner: nil, options: nil).last as? LogonPwdCell
        }
        cell?.delegate = self
        cell?.logonClours = {
           (nil) in
            let loginCtrl = LoginViewController()
            loginCtrl.loginNavTitle = "忘记密码"
            self.navigationController?.pushViewController(loginCtrl, animated: true)

        }
        cell?.selectionStyle = .None
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 500
    }
}

extension LogonViewController  {
    func logonallFunc(num: String?, pwd: String?) {
        if num == nil || pwd == nil {
            UIAlert.showAlert("账号或密码不能为空", viewController: self, alertClosure: nil)
        }else{
          
            self.logonNum = num
            self.logonPwd = pwd
            downloderLogonData()
        }
    }
}

//登录下载
extension LogonViewController: PostDownloderDelegate {
    func downloder(downloder: PostDownloder, error: NSError) {
        UIAlert.showAlert("登录失败", viewController: self, alertClosure: nil)
    }
    
    func downloder(downloder: PostDownloder, data: NSData?) {
        if let jsnData = data{
                let model = LogonRtrurnModel.parseModel(jsnData)
            dispatch_async(dispatch_get_main_queue(), { 
                self.model = model
                if self.model?.code == 400 {
                    UIAlert.showAlert("登录失败,请查看账号.密码", viewController: self, alertClosure: nil)
                }else if self.model?.code == 200 {
                    UIAlert.showAlert("登录成功", viewController: self, alertClosure: { (myCtrl) in
                        self.delegate?.logonRetuenNews(self.model!)
                        self.navigationController?.popViewControllerAnimated(true)
                        
                    })
                    
                    
                   // let myCtrl = MyViewController()
                   // myCtrl.model = model
                }
                
            })
            
        }
    }

}











