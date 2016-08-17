//
//  ReseDoubleTableViewCell.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/5.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class ReseDoubleTableViewCell: UITableViewCell {

    @IBOutlet weak var titLable: UILabel!
    
    @IBOutlet weak var priceLable: UILabel!
    
    @IBOutlet weak var sizeLable: UILabel!
    
    @IBOutlet weak var roomNumLable: UILabel!
    
    @IBOutlet weak var manMinusButton: UIButton!
    
    @IBOutlet weak var childrenAddButton: UIButton!
    @IBOutlet weak var childrenMinusButton: UIButton!
    @IBOutlet weak var childrenNumLable: UILabel!
    @IBOutlet weak var manNumLable: UILabel!
    @IBOutlet weak var manAddButton: UIButton!
    
    var roomModle : ShipDetailRoomModel!
    //房间数最大值
    var roomMax : Int!
    //儿童的最大值
    var childMax : Int!
    //成人的最大值
    var manMax : Int!
    
    @IBAction func childMinusAction(sender: AnyObject){
        var num : NSInteger = (self.childrenNumLable.text! as NSString).integerValue;
        num = num - 1;
        self.getManMax((self.manNumLable.text! as NSString).integerValue, childNum: num)
        self.childrenNumLable.text = "\(num)"
        self.roomModle.childNumStr = "\(num)"
        self.changeRoomNum();
        self.showData(self.roomModle);

        
    }
    @IBAction func childAddAction(sender: AnyObject) {
        //儿童加号方法
        var num : NSInteger = (self.childrenNumLable.text! as NSString).integerValue;
        num = num + 1;
        self.getManMax((self.manNumLable.text! as NSString).integerValue, childNum: num)
        self.childrenNumLable.text = "\(num)"
        self.roomModle.childNumStr = "\(num)"
        self.changeRoomNum();
        self.showData(self.roomModle);

    }
    
    @IBAction func manMinusAction(sender: AnyObject) {
        //成人减号方法
        var num : NSInteger = (self.manNumLable.text! as NSString).integerValue;
        num = num - 1;
        self.getManMax(num, childNum: (self.childrenNumLable.text! as NSString).integerValue)
        self.manNumLable.text = "\(num)"
        self.roomModle.manNumStr = "\(num)"
        self.changeRoomNum();
        self.showData(self.roomModle);
    }
    @IBAction func manAddAction(sender: AnyObject) {
        var num : NSInteger = (self.manNumLable.text! as NSString).integerValue;
        num = num + 1;
        self.getManMax(num, childNum: (self.childrenNumLable.text! as NSString).integerValue)
        self.manNumLable.text = "\(num)"
        self.roomModle.manNumStr = "\(num)"
        self.changeRoomNum();
        self.showData(self.roomModle);

    }
    
    func getManMax(manNum : NSInteger, childNum : NSInteger) -> Void {
        self.manMax = (self.roomModle.num as NSString).integerValue * self.roomMax - childNum;
        self.childMax = manNum * (self.roomModle.num as NSString).integerValue - manNum;
        if ((self.childMax + manNum) > (self.roomModle.num as NSString).integerValue * self.roomMax) {
            self.childMax = (self.roomModle.num as NSString).integerValue * self.roomMax - manNum;
        }

    }
    
    func changeRoomNum() -> Void {
        let peoNum : NSInteger = (self.roomModle.num as NSString).integerValue;
        let childNum : NSInteger = (self.childrenNumLable.text! as NSString).integerValue;
         let manNum : NSInteger = (self.manNumLable.text! as NSString).integerValue;
        let sum : NSInteger = manNum + childNum;
        var roomNumber : NSInteger!
        
        if (sum % peoNum != 0) {
            roomNumber = self.roomMax - (sum / peoNum) - 1;
        }else{
            roomNumber = self.roomMax - (sum / peoNum);
        }
        self.roomModle.stock = "\(roomNumber)"

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.manNumLable.addObserver(self, forKeyPath: "text", options: [NSKeyValueObservingOptions.New , NSKeyValueObservingOptions.Initial], context: nil);
        self.childrenNumLable.addObserver(self, forKeyPath: "text", options: [NSKeyValueObservingOptions.New , NSKeyValueObservingOptions.Initial], context: nil);
        
        
        self.manAddButton.addObserver(self, forKeyPath: "userInteractionEnabled", options: NSKeyValueObservingOptions.New, context: nil);
        self.childrenAddButton.addObserver(self, forKeyPath: "userInteractionEnabled", options: NSKeyValueObservingOptions.New, context: nil);
        self.childrenMinusButton.addObserver(self, forKeyPath: "userInteractionEnabled", options: NSKeyValueObservingOptions.New, context: nil);
        self.manMinusButton.addObserver(self, forKeyPath: "userInteractionEnabled", options: NSKeyValueObservingOptions.New, context: nil);

    }
    deinit {
        self.manNumLable .removeObserver(self, forKeyPath: "text")
        self.childrenNumLable .removeObserver(self, forKeyPath: "text")
        self.manAddButton .removeObserver(self, forKeyPath: "userInteractionEnabled")
        self.childrenAddButton .removeObserver(self, forKeyPath: "userInteractionEnabled")
        self.childrenMinusButton .removeObserver(self, forKeyPath: "userInteractionEnabled")
        self.manMinusButton .removeObserver(self, forKeyPath: "userInteractionEnabled")
    }
    func showData(mod : ShipDetailRoomModel) -> Void {
        self.roomModle = mod;
        if (self.roomMax == nil) {
            self.roomMax = (mod.stock as NSString).integerValue;
        }

        self.titLable.text = mod.cabin_name as String;
        self.priceLable.text = "￥\(mod.first_price)/人"
        self.sizeLable.text = "\(mod.size)m², \(mod.floors)层, 入住\(mod.num)人"
        self.roomNumLable.text = "剩余舱房: \(mod.stock)间"
        
        self.manNumLable.text = mod.manNumStr
        self.childrenNumLable.text = mod.childNumStr

    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (self.roomMax == nil) {
            return;
        }
        //成人值
        let manNum : NSInteger = (self.manNumLable.text! as NSString).integerValue;
        let childNum : NSInteger = (self.childrenNumLable.text! as NSString).integerValue;
        
        if object as? UILabel == self.childrenNumLable {
            if (childNum == 0) {
                self.childrenMinusButton.userInteractionEnabled = false;
            }else{
                self.childrenMinusButton.userInteractionEnabled = true;
                if ((childNum + manNum) == self.roomMax * (self.roomModle.num as NSString).integerValue) {
                    self.manAddButton.userInteractionEnabled = false;
                    self.childrenAddButton.userInteractionEnabled = false;
                }
                if (childNum > self.childMax) {
                    self.childrenNumLable.text =  "\(self.childMax)";
                    self.roomModle.childNumStr = "\(self.childMax)"
                }
                if (childNum < self.childMax) {
                    self.childrenAddButton.userInteractionEnabled = true;
                }else{
                    self.childrenAddButton.userInteractionEnabled = false;
                }

                    
            }
        }else if object as? UIButton == self.manAddButton || object as? UIButton == self.childrenAddButton {
            let button : UIButton = object as! UIButton
            
            if change!["new"]?.intValue == 1 {
                button.setImage(UIImage.init(named: "添加可用"), forState: UIControlState.Normal)
            }else{
                button.setImage(UIImage.init(named: "添加不可用"), forState: UIControlState.Normal)
            }
            
        
        }else if object as? UIButton == self.childrenMinusButton || object as? UIButton == self.manMinusButton {
            let button : UIButton = object as! UIButton
            if change!["new"]?.intValue == 1 {
                button.setImage(UIImage.init(named: "减少可用"), forState: UIControlState.Normal)
            }else{
                button.setImage(UIImage.init(named: "减少不可用"), forState: UIControlState.Normal)
            }

        
        }else if object as? UILabel == self.manNumLable {
            
            //成人
            if (self.roomMax == 0) {
                self.manAddButton.userInteractionEnabled = false;
            
            }else{
                self.manAddButton.userInteractionEnabled = true;
                if (manNum == 0) {
                    self.manMinusButton.userInteractionEnabled = false;
                    self.childrenAddButton.userInteractionEnabled = false;
                }else{
                    self.manMinusButton.userInteractionEnabled = true;
                    self.childrenAddButton.userInteractionEnabled = true;
                    if (childNum + manNum) == (self.roomMax * (self.roomModle.num as NSString).integerValue) {
                        self.manAddButton.userInteractionEnabled = false;
                        self.childrenAddButton.userInteractionEnabled = false;
                    }
                    if (manNum < self.manMax) {
                        self.manAddButton.userInteractionEnabled = true;
                    }else{
                        self.manAddButton.userInteractionEnabled = false;
                    }
                }
            }
        
        }else {
            
        }

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
