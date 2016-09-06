//
//  LoginViewController.swift
//  Mint
//
//  Created by qianfeng on 16/9/4.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    var textField: UITextField?
    var titleLabel: UILabel?
    var noteBtn: UIButton?
    var loginNavTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        self.addNavTitle("\(self.loginNavTitle!)")
        self.addNavBtn(nil, bgImage: "left", target: self, action: #selector(returnBtn), isLeft: true)
        self.createView()
    }
    
    func createView(){
        //提示信息
        self.titleLabel = UILabel.createLabel("请保证你的手机畅通,已接受验证短信", font: UIFont.systemFontOfSize(17), alignment: .Left, textColor: UIColor.blackColor())
        titleLabel?.frame = CGRectMake(20, 100, screenWidth, 20)
        self.view.addSubview(self.titleLabel!)
        
        //输入框
        self.textField = UITextField(frame: CGRectMake(20,130,screenWidth-40,50))
        textField?.placeholder = "请输入手机号"
        textField?.borderStyle = .RoundedRect
        self.view.addSubview(self.textField!)
        
        //获取短信按钮
        self.noteBtn = UIButton.createBtn(nil, title: "获取验证码短信", target: self, action: #selector(noteAction))
        noteBtn?.frame = CGRectMake(20, 220, screenWidth-40, 50)
        noteBtn?.backgroundColor = UIColor.orangeColor()
        noteBtn?.layer.cornerRadius = 5
        noteBtn?.layer.masksToBounds = true
        self.view.addSubview(noteBtn!)
        
        
    }

    func noteAction() {
        
    }
    
    func returnBtn(){
        self.navigationController?.popViewControllerAnimated(true)
    
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
