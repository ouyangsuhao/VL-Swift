//
//  HomeFirstHeaderViewTableViewHeaderFooterView.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/7/22.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class HomeFirstHeaderViewTableViewHeaderFooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var picImageView: UIImageView!
    var typeBlock : ((indexType: Int) -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        self.nameLable.layer.borderColor = UIColor.whiteColor().CGColor;
        self.nameLable.layer.borderWidth = 1;
        self.nameLable.backgroundColor = UIColor.init(colorLiteralRed: 231/255.0, green: 231/255.0, blue: 231/255.0, alpha: 0.2);
    }
    
    
    func showDataWithMod(arr : [HomeZeroHeaderModle]) -> Void {
        let mod : HomeZeroHeaderModle = arr.first!;

        let myImageView:UIImageView = self.viewWithTag(1000) as! UIImageView;
        myImageView.sd_setImageWithURL(NSURL.init(string: KImageIndexUrl+mod.src))
        let lable:UILabel = self.viewWithTag(100) as! UILabel;
        lable.text = mod.title;
        
    }
    
    @IBAction func shipAction(sender: UIButton){
        for num in 10000...10002 {
            let button : UIButton = self.viewWithTag(num) as! UIButton;
            button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        }
        sender.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.typeBlock(indexType:0);
        
    }
    
    @IBAction func ticketAction(sender: AnyObject){
        for num in 10000...10002 {
            let button : UIButton = self.viewWithTag(num) as! UIButton;
            button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        }
        sender.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.typeBlock(indexType:2);
     }
    
    
    @IBAction func studyAction(sender: AnyObject) {
        for num in 10000...10002 {
            let button : UIButton = self.viewWithTag(num) as! UIButton;
            button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        }
        sender.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.typeBlock(indexType:1);
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
