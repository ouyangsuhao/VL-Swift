//
//  ShipTableViewCell.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/3.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class ShipTableViewCell: UITableViewCell {
    @IBOutlet weak var headImageView: UIImageView!

    @IBOutlet weak var addressLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var detailLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showdata(mod : ShipCellModle) -> Void {
        self.headImageView.sd_setImageWithURL(NSURL.init(string: KImageIndexUrl + mod.thumb))
        self.detailLable.text = mod.product_name;
        self.priceLable.text = "￥" + mod.min_price;
        self.addressLable.text = mod.port_name + "出发";
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
