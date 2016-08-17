//
//  StewardTableViewCell.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/3.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class StewardTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var orderCountLable: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func showData(mod : StewardCellModle) -> Void {
    
        self.headImageView.sd_setImageWithURL(NSURL.init(string: KImageIndexUrl + "/" + mod.index_bg));
        self.nameLable.text = mod.name;
        self.orderCountLable.text = "\(mod.order_count)";
        self.scoreLable.text = mod.level_vir;
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
