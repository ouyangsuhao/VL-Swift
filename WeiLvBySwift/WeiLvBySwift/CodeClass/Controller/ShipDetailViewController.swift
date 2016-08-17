
//
//  ShipDetailViewController.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/5.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class ShipDetailViewController: BaseViewController ,UITableViewDelegate , UITableViewDataSource{
    //属性传值
    var  productid:String!
    var headerModelArray:NSMutableArray!
    
    //表视图属性
    @IBOutlet var listTableView: UITableView!
    //轮播图属性
    var  cycleView:SDCycleScrollView!
    //是否开放
    var isOpen:Bool!
    
    
    //概述数组
    var  sumArray:NSMutableArray!
    //房间的数组
    var roomArray:NSMutableArray!
    //行程的数组
    var strokeArray:NSMutableArray!
    //第零分区
    var zeroSectionArray:NSMutableArray!
    //第一分区
    var fisetSectionArray:NSMutableArray!
    //区头标题
    var zeroTitStr:NSString!
    //区头时间
    var zeroTimeStr:NSString!
    //房间字典
    var roomDic:NSDictionary!
    
    @IBOutlet var phoneButton: UIButton!
    @IBOutlet var reserveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:给数据源开 空间
        self.sumArray = NSMutableArray()
        self.strokeArray = NSMutableArray()
        self.zeroSectionArray = NSMutableArray()
        self.fisetSectionArray = NSMutableArray()
        self.roomArray = NSMutableArray()
        self.headerModelArray = NSMutableArray()
        
        
        self.isOpen = true
        //注册cell
        self.listTableView .registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.listTableView.registerNib(UINib.init(nibName: "ShipDeatilSumTableViewCell", bundle: nil), forCellReuseIdentifier: "sum")
        
        self.listTableView.registerNib(UINib.init(nibName: "ShipDetaiZeroSectionTableViewCell", bundle: nil), forCellReuseIdentifier: "zero")
        self.listTableView.registerNib(UINib.init(nibName: "ShipDetailRoomTableViewCell", bundle: nil
            ), forCellReuseIdentifier: "room")
        self.listTableView.registerNib(UINib.init(nibName: "ShipDetailRouteTableViewCell", bundle: nil), forCellReuseIdentifier: "route")
        self.listTableView.registerNib(UINib.init(nibName: "ShipDetaiSumHeaderViewTableViewHeaderFooterView", bundle: NSBundle.mainBundle()), forHeaderFooterViewReuseIdentifier: "headerFooter")
        
        //自适应高
        self.listTableView.estimatedRowHeight = 230;
        self.listTableView.rowHeight = UITableViewAutomaticDimension;
        //MARK:创建页眉
        self.createHeaderView()
        //数据请求
        self.requestData()
    }
    
    func createHeaderView() {
        //        let customView = UIView.init(frame: CGRectMake(0, 0, KDeviceWidth, 200))
        //        customView.backgroundColor = UIColor.purpleColor()
        
        
        let   headerView = NSBundle.mainBundle().loadNibNamed("ShipDetailHeaderView", owner: self, options: nil).first as! ShipDetailHeaderView
        headerView.backgroundColor = UIColor.whiteColor()
        print(headerView)
        //        customView.addSubview(headerView)
        self.listTableView.tableHeaderView = headerView
        self.cycleView = SDCycleScrollView.init(frame: CGRectMake(0, 0, KDeviceWidth, 200), imageNamesGroup: ["banner1"])
        headerView.addSubview(self.cycleView)
        
        headerView.bringSubviewToFront(headerView.topVew)
        
        
        //点击图片回调
        self.cycleView.clickItemOperationBlock = {
            (currentIdex:NSInteger) in
            print("点击了第\(currentIdex)张图片")
        }
    }
    
    
    
    
    //MARK:数据请求
    func requestData() {
        
        self.showProgressHUD();
        
        NewNetworkManage.requestGETWithRequest("\(KShipDetailURL)\(self.productid)", dic: [], finshBlock: { (resObjcet) in
            if  resObjcet.objectForKey("status")?.integerValue    ==  1 {
                self.hideProgressHUD();
                //封装轮播图数据
                let    headerImageArray = resObjcet.objectForKey("data")?.objectForKey("album_list") as! NSArray
                let  imageArray = NSMutableArray()
                for dic  in headerImageArray {
                    let   model = ShipDetailHeaderViewModel()
                    model.setValuesForKeysWithDictionary(dic as! Dictionary)
                    let imageStr = KImageIndexUrl + (dic.objectForKey("picture") as! String)
                    imageArray.addObject(imageStr)
                    
                    self.headerModelArray .addObject(model)
                }
                print(self.headerModelArray)
                //MARK:给轮播图赋值------------
                self.cycleView.imageURLStringsGroup = imageArray as [AnyObject]
                print(imageArray)
                let headView = self.listTableView.tableHeaderView as! ShipDetailHeaderView
                
                headView.shipLineLabel.text = (resObjcet.objectForKey("data")!.objectForKey("line_name"))  as? String
                print(headView.shipLineLabel.text)
                headView.addressLabel.text = resObjcet.objectForKey("data")!.objectForKey("harbor_name") as! String + "出发"
                
                headView.detailLabel.text = resObjcet.objectForKey("data")!.objectForKey("product_name") as? String
                headView.detailLabel.text = "本产品由" + (resObjcet.objectForKey("data")?.objectForKey("supplier_name") as! String) + "提供服务"
                headView.priceLabel.text = "¥" + (resObjcet.objectForKey("data")!.objectForKey("min_price_basic") as! String)
                print(headView.priceLabel.text)
                headView.layoutIfNeeded()
                headView.frame = CGRectMake(0, 0, KDeviceWidth, headView.titleLabel.frame.size.height + headView.detailLabel.frame.size.height + 200 + 20)
                
                //????----------------------
                //MARK:封装第零分区的数据
                let  zeroModel = ShipDetailZeroSectionModel()
                let str = resObjcet.objectForKey("data")?.objectForKey("features_sub")
                zeroModel.detailStr = str as! String
                self.zeroSectionArray.addObject(zeroModel)
                
                //MARK:封装概述数据
                let    headerModel = ShipDetailHeaderModle()
                headerModel.imageNameStr = "热推产品"
                headerModel.titleStr = "开航日期"
                let timeStr = resObjcet.objectForKey("data")?.objectForKey("setoff_date") as! NSString
                let time = timeStr.doubleValue
                
                let date = NSDate.init(timeIntervalSince1970: time )
                
                let dateFormatter = NSDateFormatter.init()
                dateFormatter.dateFormat =  "yyyy-MM-dd"
                let tempDateStr = dateFormatter.stringFromDate(date)
                let tempStr = resObjcet.objectForKey("data")?.objectForKey("setoff_date") as! String
                let dateStr = self.getWeekDay(tempStr  as String)
                headerModel.dataStr = "\(tempDateStr)\(dateStr)"
                headerModel.tipNameStr = ""
                headerModel.detailStr = ""
                
                
                //MARK:封装第二个概述model
                let twoModel = ShipDetailHeaderModle()
                twoModel.imageNameStr = "垃圾桶-副本"
                twoModel.titleStr = "产品特色"
                twoModel.dataStr = ""
                twoModel.tipNameStr  = ""
                twoModel.detailStr = resObjcet.objectForKey("data")?.objectForKey("features") as! String
                
                //MARK:封装第三个概述model
                let threeModel = ShipDetailHeaderModle()
                threeModel.imageNameStr = "cruise_detail_fee"
                threeModel.titleStr = "费用说明"
                threeModel.dataStr = ""
                threeModel.tipNameStr = "更多"
                threeModel.detailStr = ""
                
                //MARK:封装第四个概述model
                let fourModel = ShipDetailHeaderModle()
                fourModel.imageNameStr = "价格-选择"
                fourModel.titleStr = "预订须知"
                fourModel.dataStr  = ""
                fourModel.tipNameStr = "更多"
                fourModel.detailStr = ""
                
                //添加model
                self.sumArray.addObject(headerModel)
                self.sumArray.addObject(twoModel)
                self.sumArray.addObject(threeModel)
                self.sumArray.addObject(fourModel)
                
                
                //MARK:房间数组的封装
                let tempRoomDic:NSDictionary = resObjcet.objectForKey("data")?.objectForKey("room")  as! NSDictionary
                //二级界面数据传值
                self.roomDic = tempRoomDic
                self.zeroTimeStr = headerModel.dataStr
                self.zeroTitStr = resObjcet.objectForKey("data")!.objectForKey("product_name") as! NSString
                
                for (key,  _)in tempRoomDic{
                    print("-----------------------------")
                    print(key)
                    print("-----------------------------")
                    
                    print(tempRoomDic)
                    let tempArray:NSArray = (tempRoomDic.objectForKey(String(key))) as! NSArray
                    for dic in tempArray {
                        let newModel = ShipDetailRoomModel()
                        newModel.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                        self.roomArray.addObject(newModel)
                    }
                    
                }
                //MARK:封装行程的数据
                let stoDic = resObjcet.objectForKey("data")?.objectForKey("schedule") as! NSDictionary
                for (key,_ )in stoDic {
                    let newModel = ShipDetailRouteModel()
                    let tempDic = stoDic.objectForKey("\(key)") as! NSDictionary
                    newModel.setValuesForKeysWithDictionary(tempDic as! [String : AnyObject])
                    self.strokeArray.addObject(newModel)
                }
                
                
                self.fisetSectionArray = self.sumArray
                print(self.fisetSectionArray.count)
                print(self.roomArray.count)
                
                self.listTableView.reloadData()
                
            }
            
            
        }) { (conError) in
            self.hideProgressHUD();
            
        }
        
    }
    
    
    func getWeekDay(dateTime:String)->Int{
        
        let times = (dateTime as NSString).integerValue
        let days = Int(times / 86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:立即预订
    @IBAction func payAction(sender: AnyObject) {
        let resVC : ReserViewController = ReserViewController.init(nibName:"ReserViewController", bundle: nil);
        resVC.zeroTitStr = self.zeroTitStr;
        resVC.zeroTimeStr = self.zeroTimeStr
        resVC.roomDic = self.roomDic
        self.navigationController?.pushViewController(resVC, animated: true);
        
    }
    
    //MARK:表视图的代理方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if (self.fisetSectionArray == self.sumArray) {
            return 2;
        }else{
            return  3;
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            
            return self.zeroSectionArray.count;
            
        case 1:
            
            return self.fisetSectionArray.count;
            
        default:
            
            return self.strokeArray.count;
            
        }
        
    }
    
    //MARK:cell重用
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let  cell = tableView.dequeueReusableCellWithIdentifier("zero", forIndexPath: indexPath) as! ShipDetaiZeroSectionTableViewCell
            if self.isOpen == true {
                let  tempModel = self.zeroSectionArray.objectAtIndex(indexPath.row) as! ShipDetailZeroSectionModel
                let attStr = try! NSAttributedString.init(data: tempModel.detailStr.dataUsingEncoding(NSUnicodeStringEncoding)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
                cell.detailLabel.attributedText = attStr
                let tempStr = cell.detailLabel.text?.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
                cell.detailLabel.text = tempStr
                cell.tipImageView.image = UIImage.init(named: "订单明细按钮-下")
                
                
            }else {
                cell.detailLabel.text = ""
                cell.tipImageView.image = UIImage.init(named: "订单明细按钮-副本")
                
            }
            return cell
            
        case 1:
            if self.fisetSectionArray == self.sumArray {
                //自定义开航的日期
                let cell = tableView.dequeueReusableCellWithIdentifier("sum", forIndexPath: indexPath) as! ShipDeatilSumTableViewCell
                let tempModel = self.sumArray.objectAtIndex(indexPath.row) as! ShipDetailHeaderModle
                cell.showDataWithModel(tempModel)
                return cell
            }else {
                let cell = tableView.dequeueReusableCellWithIdentifier("room", forIndexPath: indexPath) as! ShipDetailRoomTableViewCell
                let tempModel = self.roomArray.objectAtIndex(indexPath.row) as! ShipDetailRoomModel
                cell.reserveBlock = {
                    () in
                    print("预定")
                }
                cell.showDataWithModel(tempModel)
                return cell
            }
            
            
        default:
            //行程的cell
            let cell = tableView.dequeueReusableCellWithIdentifier("route", forIndexPath: indexPath) as! ShipDetailRouteTableViewCell
            let tempModel = self.strokeArray.objectAtIndex(indexPath.row) as! ShipDetailRouteModel
            
            cell.showDataWithModel(tempModel)
            
            if indexPath.row == 0 {
                cell.topImageView.hidden = false
            }else {
                cell.topImageView.hidden = true
            }
            return cell
        }
        
    }
    
    
    //MARK:cell点击时间
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if indexPath.section == 0 {
            self.isOpen = !self.isOpen
            self.listTableView.reloadData()
        }
    }
    
    
    
    func  tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1{
            return 0.1
        }else {
            return 10
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView =  tableView.dequeueReusableHeaderFooterViewWithIdentifier("headerFooter") as! ShipDetaiSumHeaderViewTableViewHeaderFooterView
        headerView.butBlock = {
            (index:NSInteger) -> Void in
            if index == 0 {
                self.fisetSectionArray = self.sumArray
            }else {
                self.fisetSectionArray = self.roomArray
            }
        }
        return headerView
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
