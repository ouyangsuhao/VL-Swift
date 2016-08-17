//
//  ShipDetailRouteTableViewCell.swift
//  WeiLvBySwift
//
//  Created by Aurora on 16/8/5.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class ShipDetailRouteTableViewCell: UITableViewCell {

    
    @IBOutlet var timeImageView: UIImageView!
    
    @IBOutlet var topImageView: UIImageView!
    
    @IBOutlet var foodLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
   
    
    
    func  showDataWithModel(tempModel:ShipDetailRouteModel) {
    
        self.titleLabel.text  = "第\(tempModel.day)天\(tempModel.title)"
        var arrival = ""
        if tempModel.arrival_time.characters.count == 0 {
            arrival = ""
        }else {
            arrival = "\(tempModel.arrival_time)抵港"
        }
        var sail = ""
        if tempModel.sail_time.characters.count == 0 {
            sail = ""
        }else {
            sail = "\(tempModel.sail_time)抵港起航"
        }
      
        if sail.characters.count == 0 && arrival.characters.count == 0 {
            self.timeLabel.text = ""
            self.timeImageView.hidden = true
        }else {
            self.timeLabel.text = "航程\(arrival)\(sail)"
            self.timeImageView.hidden = false
        }
        
        let array = ["敬请期待", "包含邮轮"]
        self.foodLabel.text = "早餐\(array[(tempModel.breakfast as NSString).integerValue])  午餐\(array[(tempModel.lunch  as NSString).integerValue])  晚餐\(array[(tempModel.dinner as NSString).integerValue])"
        
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
