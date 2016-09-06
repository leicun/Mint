//
//  AllTitleCell.swift
//  Mint
//
//  Created by qianfeng on 16/8/30.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class AllTitleCell:UITableViewCell {

    @IBOutlet weak var upLabel: UILabel!
    
    @IBOutlet weak var bottmLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    
    func configModle(model: AllCollectionsModel){
        let url = NSURL(string: model.cover_image_url!)
        self.titleImage.kf_setImageWithURL(url)
        self.upLabel.text = model.title!
        if model.subtitle == nil {
            self.bottmLabel.text = ""
        }else {
            self.bottmLabel.text = model.subtitle!
        }
        
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
