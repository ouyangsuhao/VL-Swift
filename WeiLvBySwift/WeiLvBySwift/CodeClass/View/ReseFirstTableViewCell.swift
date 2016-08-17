//
//  ReseFirstTableViewCell.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/5.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class ReseFirstTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var peopleNumLable: UILabel!
    @IBOutlet weak var roomNumLable: UILabel!
    @IBOutlet weak var sizeLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var titLable: UILabel!
    
    var roomModle : ShipDetailRoomModel!
    
    //最大房间数
    var roomMaxNum : Int!
    //最大人数
    var manMaxNum : Int!
    
    @IBAction func addAction(sender: AnyObject)
    {
        var num : NSInteger = (self.roomModle.manNumStr! as NSString).integerValue;
        num = num + 1;
        self.peopleNumLable.text = "\(num)";
        self.changeRoomNum();
        self.roomModle.manNumStr = "\(num)";
        self.showData(self.roomModle)
    }
    
    @IBAction func minusAction(sender: AnyObject)
    {
        var num : NSInteger = (self.roomModle.manNumStr! as NSString).integerValue;
        num = num - 1;
        self.peopleNumLable.text = "\(num)";
        self.changeRoomNum();
        self.roomModle.manNumStr = "\(num)";
        self.showData(self.roomModle)
    }
    
    
    func changeRoomNum() -> Void {
        var roomNumber : NSInteger!;
        if self.peopleNumLable.text == "0" {
            roomNumber = self.roomMaxNum;
        }else {
            if ((self.peopleNumLable.text! as NSString).integerValue % (self.roomModle.num! as NSString).integerValue) == 0 {
                //当前剩余舱房的数目 =  总数- 用的最大房间数
                roomNumber = self.roomMaxNum - ((self.peopleNumLable.text! as NSString).integerValue / (self.roomModle.num! as NSString).integerValue);
            }else{
                roomNumber = self.roomMaxNum - ((self.peopleNumLable.text! as NSString).integerValue / (self.roomModle.num! as NSString).integerValue) - 1;
            }
        }
        self.roomModle.stock = "\(roomNumber)";
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.peopleNumLable.addObserver(self, forKeyPath: "text", options: [NSKeyValueObservingOptions.New , NSKeyValueObservingOptions.Initial], context: nil);
        
        self.addButton.addObserver(self, forKeyPath: "userInteractionEnabled", options: NSKeyValueObservingOptions.New, context: nil);
        
        self.minusButton.addObserver(self, forKeyPath: "userInteractionEnabled", options: NSKeyValueObservingOptions.New, context: nil);
        
    }
    
    func showData(mod : ShipDetailRoomModel) -> Void {
        if (self.roomMaxNum == nil) {
            self.roomMaxNum = Int(mod.stock);
            
            self.manMaxNum = Int(mod.stock)! * Int(mod.num)!
        }
        
        self.roomModle = mod;
        self.titLable.text = mod.cabin_name as String;
        self.priceLable.text = "￥" + mod.first_price + "/人"
        self.sizeLable.text = "\(mod.size)m², \(mod.floors)层, 入住\(mod.num)人"
        self.roomNumLable.text = "剩余舱房: \(mod.stock)间"
        self.peopleNumLable.text = mod.manNumStr;
        
    }
    
    deinit {
        self.peopleNumLable .removeObserver(self, forKeyPath: "text")
        self.addButton .removeObserver(self, forKeyPath: "userInteractionEnabled")
        self.minusButton .removeObserver(self, forKeyPath: "userInteractionEnabled")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if self.roomModle == nil {
            return;
        }
        //判断  当前(剩余厂房数* 房间容纳人数)能容下的人数  是否大于总人数.(最大值:  房间数目* 房间能容下的人数)
        if object as? UILabel == self.peopleNumLable {
            if self.roomMaxNum == 0 {
                self.minusButton.userInteractionEnabled = false;
                self.addButton.userInteractionEnabled = false;
            }else{
                self.minusButton.userInteractionEnabled = true;
                self.addButton.userInteractionEnabled = true;
            
                let peoNum : NSInteger = (self.peopleNumLable.text! as NSString).integerValue;
                
                if peoNum == 0 {
                    self.minusButton.userInteractionEnabled = false;

                }else {
                    self.minusButton.userInteractionEnabled = true;
                    if peoNum < self.manMaxNum {
                        self.addButton.userInteractionEnabled = true;

                    }else {
                        self.addButton.userInteractionEnabled = false;
                    }
                }
            }
           
            
            
        }else if object as? UIButton == self.addButton {
            
            if change!["new"]?.intValue == 1 {
                self.addButton.setImage(UIImage.init(named: "添加可用"), forState: UIControlState.Normal);
            }else{
                self.addButton.setImage(UIImage.init(named: "添加不可用"), forState: UIControlState.Normal);
                
            }
            
            
        }else if object as? UIButton == self.minusButton {
            
            if change!["new"]?.intValue == 1 {
            
                self.minusButton.setImage(UIImage.init(named: "减少可用"), forState: UIControlState.Normal);
            }else{
                self.minusButton.setImage(UIImage.init(named: "减少不可用"), forState: UIControlState.Normal);
            }
            
        }else {
            
            
        }
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
