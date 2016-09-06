//
//  SingViewCell.swift
//  Mint
//
//  Created by qianfeng on 16/8/21.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class SingViewCell: UICollectionViewCell {
    @IBOutlet weak var bgImage: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var leftLabel: UILabel!
    
    
    @IBOutlet weak var disLabel: UILabel!
    
    
    func configModel(model:TypeModel){
        titleLabel.text = model.name!
        leftLabel.text = "￥\(model.price!)"
        let url = NSURL(string: (model.cover_image_url)!)
        bgImage.kf_setImageWithURL(url)
        disLabel.text = "\(model.favorites_count!)"
        
    }
        
    func searchModel(model:CommendityItemsModel){
        titleLabel.text = model.name!
        leftLabel.text = "￥\(model.price!)"
        let url = NSURL(string: (model.cover_image_url)!)
        bgImage.kf_setImageWithURL(url)
        disLabel.text = "\(model.favorites_count!)"
        
    }

    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

