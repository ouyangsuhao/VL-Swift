//
//  ReseFirstHeaderViewHeaderFooterView.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/5.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class ReseFirstHeaderViewHeaderFooterView: UITableViewHeaderFooterView {

    var headerBlock : ((viewTag : Int)->Void)!
    
    func creatSubView(dic : NSDictionary) -> Void {
        self.removeFromSuperview();
        
        let titArray = dic.allKeys;
        
        let numLine = titArray.count - 1;
    
        let witdth : CGFloat = (KDeviceWidth - CGFloat(numLine)) / CGFloat(titArray.count);
        
        
        for i in 0..<titArray.count {
            let view : UIView = UIView.init(frame: CGRectMake(CGFloat(i) * (witdth + 1), 0, witdth, 120))
            view.backgroundColor = UIColor.whiteColor();
            self.addSubview(view);
            view.tag = i + 1000;
            view.userInteractionEnabled = true;
            let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.tapAction(_:)))
            view.addGestureRecognizer(tap);
            
            
            let temArray : NSArray = dic.objectForKey(titArray[i]) as! NSArray;
            //排序 first_price 最低价排序.
            let des : NSSortDescriptor = NSSortDescriptor.init(key: "first_price", ascending: true);
            
            let goodArray : NSArray = temArray.sortedArrayUsingDescriptors([des]);
            let titLable : UILabel = UILabel.init(frame: CGRectMake(0, 30, view.frame.size.width, 20))
            titLable.text = titArray[i] as? String;
            titLable.textColor = UIColor.orangeColor()
            titLable.textAlignment = NSTextAlignment.Center;
            view.addSubview(titLable);
            

            
            let priceLable : UILabel = UILabel.init(frame: CGRectMake(0, titLable.frame.size.height + titLable.frame.origin.y + 20, view.frame.size.width, 20));
            
            priceLable.text = goodArray.firstObject?.objectForKey("first_price") as? String;
            
            priceLable.textAlignment = NSTextAlignment.Center;
            priceLable.textColor = UIColor.orangeColor();
            view.addSubview(priceLable);
        }
        
        for num in 0..<numLine {
            let labe : UILabel  = UILabel.init(frame: CGRectMake(witdth * CGFloat(num) + witdth , 20, 1, 80));
            labe.backgroundColor = UIColor.orangeColor();
            self.addSubview(labe);
        }
    }
    
    func tapAction(tap : UITapGestureRecognizer) -> Void {
        self.headerBlock(viewTag:(tap.view?.tag)! - 1000);
    }

}
