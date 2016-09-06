//
//  LikeCommodityCell.swift
//  Mint
//
//  Created by qianfeng on 16/9/5.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class LikeCommodityCell: UITableViewCell {

    @IBOutlet weak var likeImage: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
