//
//  LogonCell.swift
//  Mint
//
//  Created by qianfeng on 16/8/30.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
protocol LogonPwdCellDelegate: NSObjectProtocol {
    func logonallFunc(num:String?, pwd: String?)
}
class LogonPwdCell: UITableViewCell {
    var delegate: LogonPwdCellDelegate?
    var logonClours: ((String?)->Void)?
    @IBOutlet weak var numTextfeld: UITextField!
    
    @IBOutlet weak var pwdTextfeld: UITextField!
    
    @IBOutlet weak var sinaBtn: UIButton!
    
    @IBAction func sina(sender: UIButton) {
        
        
        
    }
    
    
    @IBAction func wuixingBtn(sender: UIButton) {
    }
    
    @IBAction func qqBtn(sender: UIButton) {
    }
       
    
    @IBAction func logonBtn(sender: UIButton) {
        if self.numTextfeld.text == "" || self.pwdTextfeld.text == "" {
                self.delegate?.logonallFunc(nil,pwd: nil)
        }else {
            self.delegate?.logonallFunc(self.numTextfeld.text, pwd: self.pwdTextfeld.text)
        }
        
    }
    
    @IBAction func forgetpwdBtn(sender: UIButton) {
        self.logonClours!(nil)
        
    }
    
      override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
