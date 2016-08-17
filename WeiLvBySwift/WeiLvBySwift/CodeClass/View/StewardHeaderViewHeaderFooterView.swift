//
//  StewardHeaderViewHeaderFooterView.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/3.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class StewardHeaderViewHeaderFooterView: UITableViewHeaderFooterView {

    var selBlock : ((tit : String) -> Void)!
    
    
    override func awakeFromNib() {
        self.backgroundView = UIView.init(frame: self.bounds);
        self.backgroundView?.backgroundColor = UIColor.whiteColor();
    
    }
    
    @IBAction func caseAction(sender: AnyObject) {
        //案例按钮
        print("案例");
        self.selBlock(tit: "案例");
    }
    
    @IBAction func scoreAction(sender: AnyObject) {
        //评分
        print("评分");
        self.selBlock(tit: "评分");

    }
    
    @IBAction func allAction(sender: AnyObject) {
        //全部
        print("全部");
        self.selBlock(tit: "全部");

    }

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
