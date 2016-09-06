//
//  PlaceCell.swift
//  Mint
//
//  Created by qianfeng on 16/8/22.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

protocol PlaceCellDelegate: NSObjectProtocol {
    func placeId(id:Int,navTitle: String?)
}


class PlaceCell: UITableViewCell {

    var delegate: PlaceCellDelegate?
    @IBAction func clickBtn(sender: UIButton) {
        
    }
    
    var channelsArray: Array<SpecialDataChannelsMOdel>?{
        didSet{
            showData()
        }
    }
    
    
    func showData(){
        let cnt = channelsArray?.count
        
        if cnt > 0 {
            
        
            
            for i in 0..<5{
                let  imageModel = channelsArray![i]

                    let url = NSURL(string: imageModel.icon_url!)
                    
                    let btnView = self.contentView.viewWithTag(100+i)
                    if btnView?.isKindOfClass(UIButton.self) == true{
                        let btn = btnView as! UIButton
                        
                        btn.kf_setBackgroundImageWithURL(url, forState: .Normal, placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                        btn.addTarget(self, action: #selector(placeBtn(_:)), forControlEvents: .TouchUpInside)
                }
                
                let labelView = contentView.viewWithTag(200+i)
                if labelView?.isKindOfClass(UILabel.self) == true {
                    let label = labelView as! UILabel
                    label.text = imageModel.name
                }
            }
        }
        
    }
    
    
    func placeBtn(btn: UIButton){
        let index = btn.tag - 100
        let id = Int(channelsArray![index].id!)
        let name = channelsArray![index].name
        self.delegate?.placeId(id,navTitle: name)
    
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
