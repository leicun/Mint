//
//  ScrollDeatailCell.swift
//  Mint
//
//  Created by qianfeng on 16/8/27.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class ScrollDeatailCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!

    
    @IBOutlet weak var bgImageView: UIImageView!
    
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    @IBAction func praiseBtn(sender: UIButton) {
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func configModel(model: ScrollDetailPostsModel){
        bgView.layer.cornerRadius = 15
        bgView.layer.masksToBounds = true
        let url = NSURL(string: (model.cover_image_url)!)
        self.bgImageView.kf_setImageWithURL(url, placeholderImage:UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        bgImageView.layer.cornerRadius = 15
        bgImageView.layer.masksToBounds = true
        
        commentLabel.text = "\((model.likes_count)!)"
        titleLabel.text = model.title!
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
