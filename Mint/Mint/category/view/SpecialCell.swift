//
//  SpecialCell.swift
//  Mint
//
//  Created by qianfeng on 16/8/22.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit

protocol SpecialCellDelegate:NSObjectProtocol {
    func specialId(id:Int?)
}

class SpecialCell: UITableViewCell {

    var singClosure: CellClosure?
    var delegate: SpecialCellDelegate?
    @IBAction func allBtn(sender: UIButton) {
        
        self.delegate?.specialId(nil)
        
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var collectionsModel: Array<CollectionsModel>? {
        didSet{
            showData()
        }
    }
    
    func showData(){
        let cnt = collectionsModel?.count
        self.scrollView.showsHorizontalScrollIndicator = false
        
        if cnt > 0{
            let conainerView = UIView.createView()
            
            
            scrollView.addSubview(conainerView)
            
            conainerView.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.edges.equalTo(self!.scrollView)
                
                make.height.equalTo(self!.scrollView)
            })
        
    
        var lastView: UIView? = nil
    
        for i in 0..<cnt!{
            let model = collectionsModel![i]
            let imageView = UIImageView.createImageView(nil)
            imageView.layer.cornerRadius = 10
            imageView.layer.masksToBounds = true
            let url = NSURL(string: model.banner_image_url!)
            imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            imageView.userInteractionEnabled = true
            imageView.tag = 500+i
            let g = UITapGestureRecognizer(target: self, action: #selector(gotoDetail(_:)))
            imageView.addGestureRecognizer(g)
            conainerView.addSubview(imageView)
            
            imageView.snp_makeConstraints(closure: { (make) in
                make.top.bottom.equalTo(conainerView)
                make.width.equalTo(screenWidth/3)
                if i == 0{
                    make.left.equalTo(conainerView.bounds.size.width+10)
                }else{
                    make.left.equalTo((lastView?.snp_right)!).offset(10)
                }
            })
            lastView = imageView
        }
        
        conainerView.snp_makeConstraints { (make) in
           make.right.equalTo((lastView?.snp_right)!)
        }
            
        }
    }
    
    func gotoDetail(g: UIGestureRecognizer) {
        let index = (g.view?.tag)! - 500
       
        let id = Int(collectionsModel![index].id!)
        self.delegate?.specialId(id)
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
