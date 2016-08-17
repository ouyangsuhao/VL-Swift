//
//  ShipHeaderTableViewHeaderFooterView.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/3.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class ShipHeaderTableViewHeaderFooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var moreImageView: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    var tapBlock : (()->Void)!;
    
    
    override func awakeFromNib() {
        self.userInteractionEnabled = true;
        let tap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.tap));
        self.addGestureRecognizer(tap);
        
    }
    
    func tap() -> Void {
        self.tapBlock();
    }
    
    func showHeaderView(mod : ShipHeaderModle) -> Void {
        self.iconImageView.image = UIImage.init(named: mod.iconNameStr);
        self.titleLable.text = mod.titNameStr;
        self.moreImageView.hidden = !mod.isMore;
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
