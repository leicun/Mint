//
//  HomeScrollCell.swift
//  Mint
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 i. All rights reserved.
//

import UIKit
import Alamofire
class HomeScrollCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    var clickClosure: CellClosure?
    var scrollModel: ScrollModel?
    //http://api.bohejiaju.com/v1/collections/19/posts?gender=1&generation=1&limit=20&offset=0
    var bannerArray: Array<arrayModel>?{
        didSet{
            showModel()
        }
    }
    
    func showModel(){
        
        for oldSub in scrollView.subviews {
        
            oldSub.removeFromSuperview()
            
        }
        
        let cnt = bannerArray?.count
        if cnt > 0{
            let containerView = UIView.createView()
            scrollView.addSubview(containerView)
            
            containerView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(self.scrollView)
                make.height.equalTo(self.scrollView)
            })
            
            var lastView: UIView? = nil
            for i in 0..<cnt!{
                let model = bannerArray![i]
                let tmpImageView = UIImageView.createImageView(nil)
                let url = NSURL(string: model.image_url! as String)
                let image = UIImage(named: "sdefaultImage")
                
                tmpImageView.kf_setImageWithURL(url, placeholderImage: image, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                tmpImageView.tag = 500+i
                tmpImageView.userInteractionEnabled = true
                let g = UITapGestureRecognizer(target: self, action: #selector(gotoDetail(_:)))
                
                tmpImageView.addGestureRecognizer(g)
                containerView.addSubview(tmpImageView)
                
                tmpImageView.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(containerView)
                    make.width.equalTo(screenWidth)
                   
                    if i == 0{
                        make.left.equalTo(containerView)
                    }else{
                        make.left.equalTo((lastView?.snp_right)!)
                    }
                })
                lastView = tmpImageView
                
            }
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo((lastView?.snp_right)!)
            })

            pageControl.numberOfPages = cnt!
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.delegate = self
            scrollView.pagingEnabled = true
        }
    }
    
    func gotoDetail(g: UIGestureRecognizer) {
        let index = (g.view?.tag)! - 500
          let detailModel = bannerArray![index]
        let id = Int((detailModel.target?.id)!)
      
         clickClosure!(nil, id)
        
       
    
    }
    class func creataeCell(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:ScrollModel,cellClosure: CellClosure)->HomeScrollCell{
        let cellId = "homeScrollId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? HomeScrollCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("HomeScrollCell", owner: nil, options: nil).last as? HomeScrollCell
        }
        cell?.bannerArray = model.data?.banners
        cell?.clickClosure = cellClosure
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

extension HomeScrollCell:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        pageControl.currentPage = index
    }

}


