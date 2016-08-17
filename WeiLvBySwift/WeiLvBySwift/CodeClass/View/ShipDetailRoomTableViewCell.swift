//
//  ShipDetailRoomTableViewCell.swift
//  WeiLvBySwift
//
//  Created by Aurora on 16/8/5.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class ShipDetailRoomTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var headerImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var sizeLabel: UILabel!
    
    @IBOutlet var perNumLabel: UILabel!
    
    @IBOutlet var froolLabel: UILabel!
    
    
    @IBOutlet var priceLabel: UILabel!
    
    //block属性.预定按钮
    var  reserveBlock:(()->Void)!
    
    
    //点击预定按钮
    @IBAction func reserveButtonAction(sender: AnyObject) {
        self.reserveBlock()
    }
    
    //展示数据
    func showDataWithModel(tempModel:ShipDetailRoomModel) {
    self.headerImageView.sd_setImageWithURL(NSURL.init(string: "\(KImageIndexUrl)\(tempModel.cabin_thumb)"))
    self.titleLabel.text = "\(tempModel.cabin_name)"
        self.perNumLabel.text = "\(tempModel.num)"
        self.sizeLabel.text = "\(tempModel.size)"
        self.froolLabel.text = "\(tempModel.floors)"
        self.priceLabel.text = "\(tempModel.first_price)"
    
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
