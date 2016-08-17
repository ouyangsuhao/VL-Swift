//
//  ReseZeroHeaderViewHeaderFooterView.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/5.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class ReseZeroHeaderViewHeaderFooterView: UITableViewHeaderFooterView {

    var titlable : UILabel!
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.whiteColor();
        self.titlable = UILabel.init(frame: CGRectMake(0, 0, KDeviceWidth, 40));
        self.titlable.textColor = UIColor.blackColor();
        self.titlable.font = UIFont.systemFontOfSize(15);
        self.titlable.numberOfLines = 0;
        self.contentView.addSubview(self.titlable);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
