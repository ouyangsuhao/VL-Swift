//
//  ShipDeatilSumTableViewCell.swift
//  WeiLvBySwift
//
//  Created by Aurora on 16/8/5.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class ShipDeatilSumTableViewCell: UITableViewCell {

    
    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var titLabel: UILabel!
    
    
    @IBOutlet var moreImageView: UIImageView!
    
    
    @IBOutlet var dateLabel: UILabel!
    
    
    @IBOutlet var detailLabel: UILabel!
    
    
    func  showDataWithModel(tempModel:ShipDetailHeaderModle) {
        self.iconImageView.image = UIImage.init(named: tempModel.imageNameStr as String)
        self.titLabel.text = tempModel.titleStr as String
        self.moreImageView.image = UIImage.init(named: tempModel.tipNameStr as String)
        self.dateLabel.text = tempModel.dataStr as String
        let attrStr = try! NSAttributedString.init(data: tempModel.detailStr.dataUsingEncoding(NSUnicodeStringEncoding)! , options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
        
        self.detailLabel.attributedText = attrStr
        //去掉label
        let tempStr = self.detailLabel.text?.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        
        self.detailLabel.text = tempStr
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
