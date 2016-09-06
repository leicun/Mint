//
//  CaretoryCell.swift
//  Mint
//
//  Created by qianfeng on 16/8/24.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

protocol CaretoryCellDelegate: NSObjectProtocol {
    func caretouyId(id: Int ,title: String)
}


class CaretoryCell: UITableViewCell {
    var deletate: CaretoryCellDelegate?

    
    @IBAction func clickBtn(sender: UIButton) {
    }
    
    var channelModel: Array<SpecialDataChannelsMOdel>? {
        didSet {
            showData()
        }
    }
    
    func showData(){
        let cnt = channelModel?.count
        if cnt > 0 {
            for i in 0..<cnt! {
                let imageModel = channelModel![i]
                
                let url = NSURL(string: imageModel.icon_url!)
                let btnView = contentView.viewWithTag(100+i)
                if btnView?.isKindOfClass(UIButton.self) == true {
                    let btn = btnView as! UIButton
                    btn.kf_setBackgroundImageWithURL(url, forState: .Normal, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    let g = UITapGestureRecognizer(target: self, action: #selector(gotoDetail(_:)))
                    btn.addGestureRecognizer(g)
                }
                
                let labelView = contentView.viewWithTag(200+i)
                if labelView?.isKindOfClass(UILabel.self) == true {
                    let label = labelView as! UILabel
                    label.text = imageModel.name!
                }
            }
        }
    
    }
    
    
    func gotoDetail(btn: UIGestureRecognizer) {
        let index = (btn.view?.tag)! - 100
        let id = Int(channelModel![index].id!)
        let title = channelModel![index].name
        self.deletate?.caretouyId(id, title: title!)
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
