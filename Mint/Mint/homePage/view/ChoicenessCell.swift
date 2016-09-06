//
//  ChoicenessCell.swift
//  Mint
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

class ChoicenessCell: UITableViewCell {

    @IBAction func praiseBtn(sender: UIButton) {
    }
    
    @IBOutlet weak var appImage: UIImageView!
    
    @IBOutlet weak var support: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var itemsModel:ItemsModel?{
        didSet {
          
            showData()
        }
    
    }
    
    func showData(){
        if itemsModel?.cover_image_url != nil{
            let url = NSURL(string: (itemsModel?.cover_image_url)!)
            appImage.kf_setImageWithURL(url)
            appImage.layer.cornerRadius = 20
            appImage.layer.masksToBounds = true
        }
            
        support.text = (itemsModel?.title)!
        titleLabel.text = "\((itemsModel?.likes_count)!)"
        
    }
    
    class func createCell(tableView: UITableView,indexPath: NSIndexPath,model: [ItemsModel]) -> ChoicenessCell {
        
        let cellId = "choicenessCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? ChoicenessCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("ChoicenessCell", owner: nil, options: nil).last as? ChoicenessCell
        }
        
        cell?.itemsModel = model[indexPath.row]
     
        return cell!
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
