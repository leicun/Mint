//
//  LogonCell.swift
//  Mint
//
//  Created by qianfeng on 16/8/24.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
protocol LogonCellDelegate: NSObjectProtocol {
    func logonBtn()
}

class LogonCell: UITableViewCell {

    var delegate: LogonCellDelegate?
    @IBAction func logonBtn(sender: UIButton) {
        self.delegate?.logonBtn()
        
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func newsAction(sender: AnyObject) {
        self.delegate?.logonBtn()
    }
    
    @IBOutlet weak var avatarImage: UIImageView!
    func configModel(model: LogonRtrurnModel){
        
        self.nameLabel.text = model.data?.nickname!
        let url = NSURL(string: (model.data?.avatar_url)!)
        self.avatarImage.kf_setImageWithURL(url)
        self.avatarImage.layer.cornerRadius = 25
        self.avatarImage.layer.masksToBounds = true
        
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
