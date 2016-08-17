//
//  HomeTableViewCell.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/1.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var rightLable: UILabel!
    @IBOutlet weak var titDetaillable: UILabel!
    @IBOutlet weak var leftLable: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    func showDataWithModle(mod : HomeCellModle) -> Void {
    
        self.headImageView.sd_setImageWithURL(NSURL.init(string: mod.headImageUrlStr));
        self.titDetaillable.text =  mod.titDetailStr;
        self.leftLable.text = mod.addressStr;
        self.rightLable.text = mod.priceCountStr;
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
