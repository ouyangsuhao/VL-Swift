//
//  ReserViewController.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/5.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class ReserViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!

    var roomArray : NSMutableArray!
    var dataArray : NSMutableArray!
    //区头标题
    var zeroTitStr:NSString!
    //区头时间
    var zeroTimeStr:NSString!
    //房间字典
    var roomDic:NSDictionary!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roomArray = NSMutableArray();
        self.dataArray = NSMutableArray();

        //封装数据源
        for (_, temArr) in self.roomDic {
            let  temMolArray : NSMutableArray = NSMutableArray();
            for dic in temArr as! NSArray {
                let modle = ShipDetailRoomModel.init();
                modle.setValuesForKeysWithDictionary(dic as! [String : AnyObject]);
                modle.manNumStr = "0";
                modle.childNumStr = "0";
                temMolArray.addObject(modle);
            }
            self.roomArray.addObject(temMolArray)
        }
        self.dataArray = self.roomArray.firstObject as! NSMutableArray;
        self.myTableView.reloadData();
        
        self.myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.myTableView.registerNib(UINib.init(nibName: "ReseZeroTableViewCell", bundle: nil), forCellReuseIdentifier: "zero");

        self.myTableView.registerNib(UINib.init(nibName: "ReseFirstTableViewCell", bundle: nil), forCellReuseIdentifier: "first");
        
        self.myTableView.registerNib(UINib.init(nibName: "ReseDoubleTableViewCell", bundle: nil), forCellReuseIdentifier: "double");
        
        
        //区头
        self.myTableView.registerClass(ReseZeroHeaderViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "zeroHeader")
        self.myTableView.registerClass(ReseFirstHeaderViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "firstHeader")

        self.myTableView.registerNib(UINib.init(nibName: "ReseThirdHeaderViewHeaderFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "thirdHeader")
    }

    //MARK : UITableViewDelegate, UITableViewDataSource
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header : ReseZeroHeaderViewHeaderFooterView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("zeroHeader") as! ReseZeroHeaderViewHeaderFooterView;
            header.titlable.text = self.zeroTitStr as String;
            return header;
        case 1:
            let header : ReseFirstHeaderViewHeaderFooterView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("firstHeader") as! ReseFirstHeaderViewHeaderFooterView;
            header.creatSubView(self.roomDic)
            header.headerBlock = {(viewTag : Int) in
                self.dataArray = self.roomArray.objectAtIndex(viewTag) as! NSMutableArray;
                self.myTableView.reloadData();
            
            }
            return header;
        default:
            let header : ReseThirdHeaderViewHeaderFooterView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("thirdHeader") as! ReseThirdHeaderViewHeaderFooterView;
            return header;
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 106;
        default:
            return 40;
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 40
        case 1:
            return 120
        case 3:
            return 160
        default:
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1;
        case 1:
            return self.dataArray.count;
        case 2:
            return 2;
        default:
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell : ReseZeroTableViewCell = tableView.dequeueReusableCellWithIdentifier("zero", forIndexPath: indexPath) as! ReseZeroTableViewCell
            cell.timeLable.text = self.zeroTimeStr as String;
            return cell;

        case 1:
            let mod = self.dataArray.objectAtIndex(indexPath.row) as! ShipDetailRoomModel;

            if (mod.num! as NSString).intValue <= 2 {
                let cell : ReseFirstTableViewCell = tableView.dequeueReusableCellWithIdentifier("first", forIndexPath: indexPath) as! ReseFirstTableViewCell
                cell.showData(mod);
                return cell;
            }else{
                let cell : ReseDoubleTableViewCell = tableView.dequeueReusableCellWithIdentifier("double", forIndexPath: indexPath) as! ReseDoubleTableViewCell;
                cell.showData(mod);
                return cell;
            }
            
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath);
            return cell;
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
