//
//  HomeZeroHeaderViewTableViewHeaderFooterView.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/7/22.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class HomeZeroHeaderViewTableViewHeaderFooterView: UITableViewHeaderFooterView {
    //点击了更多的回调
    var moreBlock : (()->Void)!
    //点击了四个图片的回调
    var typeBlock : ((num:Int) -> Void)!
    //点击底部图片回调
    var footerBlock :(()->Void)!
    

    
    
    override func awakeFromNib() {
        self.userInteractionEnabled = true;
        let lable:UILabel = self.viewWithTag(100) as! UILabel;
        lable.userInteractionEnabled = true;
        let moreTap = UITapGestureRecognizer.init(target: self, action:#selector(HomeZeroHeaderViewTableViewHeaderFooterView.moreAction));
        lable.addGestureRecognizer(moreTap);
        
        for num in 1000...1003 {
            let myImageView:UIImageView = self.viewWithTag(num) as! UIImageView;
            myImageView.userInteractionEnabled = true;
           
            let typeTap = UITapGestureRecognizer.init(target: self, action: #selector(self.indexAction(_:)));
            myImageView.addGestureRecognizer(typeTap)
            
        }
        
        let footerImageView : UIImageView = self.viewWithTag(10000) as! UIImageView;
        footerImageView.userInteractionEnabled = true;
        let footerTap = UITapGestureRecognizer.init(target: self, action: #selector(self.footerAction));
        footerImageView.addGestureRecognizer(footerTap);
        
    }
    //更多的方法
    func moreAction(){
        self.moreBlock();
    }
 
    //四个图片方法
    func indexAction(tap : UITapGestureRecognizer){
        let selNum : Int = (tap.view?.tag)!;
        self.typeBlock(num : selNum);
    }
    
    //管家
    func footerAction(){
        self.footerBlock();  
    }
    
    
    //赋值方法
    func showDataWithMod(arr : [HomeZeroHeaderModle]) -> Void {
        for i in  0..<arr.count {
            let mod : HomeZeroHeaderModle = arr[i];
            let myImageView:UIImageView = self.viewWithTag(i + 1000) as! UIImageView;
            let imageUrl = KImageIndexUrl + mod.src;
            print(imageUrl);
            myImageView.sd_setImageWithURL(NSURL.init(string: imageUrl));

            let lable:UILabel = self.viewWithTag(100000 + i) as! UILabel;
            lable.text = mod.title;

        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
