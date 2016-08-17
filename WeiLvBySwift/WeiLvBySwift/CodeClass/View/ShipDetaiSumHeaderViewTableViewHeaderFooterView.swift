//
//  ShipDetaiSumHeaderViewTableViewHeaderFooterView.swift
//  WeiLvBySwift
//
//  Created by Aurora on 16/8/5.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class ShipDetaiSumHeaderViewTableViewHeaderFooterView: UITableViewHeaderFooterView {

    var  butBlock:((NSInteger)->Void)!
    
    @IBAction func sumAction(sender: AnyObject) {
        self.butBlock(0)
    }
    
    
    @IBAction func strokAction(sender: AnyObject) {
        self.butBlock(1)

    }
    

}
