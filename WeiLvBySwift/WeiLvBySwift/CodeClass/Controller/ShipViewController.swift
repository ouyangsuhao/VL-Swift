//
//  ShipViewController.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/1.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class ShipViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    //轮播图
    var cycleScrollView : SDCycleScrollView!
    //cell的数据源
    var dataArray : Array <ShipCellModle>!

    //区头数据源
    var headerArray : Array <ShipHeaderModle>!

    //轮播图数据源
    var ringArray : Array <HeaderViewModle>!
    //航线数据源
    var shipLineArray : Array <ShipLineModle>!;

    
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shipLineArray = [ShipLineModle]();
        self.ringArray = [HeaderViewModle]();
        self.headerArray = [ShipHeaderModle]();
        self.dataArray = [ShipCellModle]();

        //封装分区头的数据
        let firstHeaderMod : ShipHeaderModle = ShipHeaderModle.init();
        firstHeaderMod.iconNameStr = "cruise_detail_tour_ship";
        firstHeaderMod.titNameStr = "邮轮日历";
        firstHeaderMod.isMore = true;
        self.headerArray.append(firstHeaderMod);
        
        let selHeaderMod : ShipHeaderModle = ShipHeaderModle.init();
        selHeaderMod.iconNameStr = "报名日期-列表";
        selHeaderMod.titNameStr = "精品航线";
        selHeaderMod.isMore = false;
        self.headerArray.append(selHeaderMod);
        
        self.listTableView.registerNib(UINib.init(nibName: "ShipTableViewCell", bundle: nil), forCellReuseIdentifier: "cell");
        self.listTableView.registerNib(UINib.init(nibName: "ShipHeaderTableViewHeaderFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "header");
        //预估高
        self.listTableView.estimatedRowHeight = 240;
        self.listTableView.rowHeight = UITableViewAutomaticDimension;
        //添加轮播图
        self.addRingView();
        //请求数据
        self.requestData();
    
    }
    
   override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    self.tabBarController?.tabBar.hidden = true
    }
    
    func addRingView(){

        let headerView : UIView = UIView.init(frame: CGRectMake(0, 0, KDeviceWidth, 300));
        self.cycleScrollView = SDCycleScrollView.init(frame: CGRectMake(0, 0, KDeviceWidth, 200), imageNamesGroup: ["banner1.png"]);
        self.cycleScrollView.clickItemOperationBlock = {(index:Int) in
            print(index);
        };
        headerView.addSubview(self.cycleScrollView);

        //添加航线
        let space = CGFloat((KDeviceWidth - 20 - 240) / 3);
        
        for num in 0..<4 {
            let imagView : UIImageView = UIImageView.init(frame: CGRectMake(10 + (60 + space) * CGFloat(num), 210, 60, 60))
            imagView.tag = 1000 + num;
            imagView.userInteractionEnabled = true;
            headerView.addSubview(imagView);
            
            //添加手势
            let tap : UITapGestureRecognizer = UITapGestureRecognizer
                .init(target: self, action: #selector(self.tapAction(_:)));
            imagView.addGestureRecognizer(tap);

            
            let lable : UILabel = UILabel.init(frame: CGRectMake(imagView.frame.origin.x - 10, imagView.frame.origin.y + imagView.frame.size.height + 10, 80, 20));
            lable.tag = 100 + num;
            lable.font = UIFont.systemFontOfSize(15);
            lable.text = "虎哥最帅";
            lable.textAlignment = NSTextAlignment.Center;
            headerView.addSubview(lable);
            
        }
      
        self.listTableView.tableHeaderView = headerView;
     }

    func requestData() -> Void {
        self.showProgressHUD();
        NewNetworkManage.requestGETWithRequest(KShipDataURL, dic: ["city_id":"149", "assistant_id":"0"], finshBlock: { (resObjcet) in
            self.hideProgressHUD();
            if resObjcet.objectForKey("status")?.intValue == 1 {
                //封装轮播图数据
                let temAdArray = (resObjcet.objectForKey("data")?.objectForKey("ad")) as! NSArray;
                var imageArray  = [String]();
                
                for dic in temAdArray {
                    let imagUrlStr : String = KImageIndexUrl + ((dic.objectForKey("src")) as! String);
                    imageArray.append(imagUrlStr);
                    
                    let mod : HeaderViewModle = HeaderViewModle.init();
                    mod.setValuesForKeysWithDictionary(dic as! [String : AnyObject]);
                    self.ringArray.append(mod);
                }
                self.cycleScrollView.imageURLStringsGroup = imageArray;
                
                //封装航线
                let line_listArray = resObjcet.objectForKey("data")?.objectForKey("line_list") as! NSArray;
                print(line_listArray);
                for dic in line_listArray {
                    let mod : ShipLineModle = ShipLineModle.init();
                    mod.setValuesForKeysWithDictionary(dic as! [String : AnyObject]);
                    self.shipLineArray.append(mod);
                }
                //给航线控件赋值
                for mod in self.shipLineArray {
                    let index : Int =  self.shipLineArray.indexOf(mod)!;
                    let imageView : UIImageView = self.listTableView.tableHeaderView?.viewWithTag(1000+index) as! UIImageView;
                    let lable : UILabel = self.listTableView.tableHeaderView?.viewWithTag(100+index) as! UILabel;
                    let imagStr : String =  KImageIndexUrl + mod.pic;
                    imageView.sd_setImageWithURL(NSURL.init(string: imagStr));
                    lable.text = mod.line_name;
                }
                
                //封装cell数据
                let temShipArray = resObjcet.objectForKey("data")?.objectForKey("tehuichanpin") as! NSArray;
                for dic in temShipArray {
                    let mod : ShipCellModle = ShipCellModle.init();
                    mod.setValuesForKeysWithDictionary(dic as! [String : AnyObject]);
                    self.dataArray.append(mod);
                }
                
                self.listTableView.reloadData();
            }
            
            
            
            }) { (conError) in
                self.hideProgressHUD();
        }
    }
    
    
    func tapAction(tap:UITapGestureRecognizer) -> Void {
    //航线点击
        let indexTag : Int  = (tap.view?.tag)!;
        print(indexTag);
        
    }


    ///MARK :UITableViewDelegate, UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0;
        default:
            
            return self.dataArray.count;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ShipTableViewCell;
        cell.showdata(self.dataArray[indexPath.row]);
        return cell;
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.headerArray.count;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("header") as! ShipHeaderTableViewHeaderFooterView;
        headerView.showHeaderView(self.headerArray[section]);
        headerView.tapBlock = {() in
            if section == 0 {
                print("跳转到日历界面");
                let calent : CalenViewController = CalenViewController.init();
                self.navigationController?.pushViewController(calent, animated: true);
            }else{
                print("不跳转");
            }
        };
        return headerView;
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let tempModel = dataArray[indexPath.row]
        let detailVC :ShipDetailViewController = ShipDetailViewController.init(nibName: "ShipDetailViewController", bundle: nil);
    detailVC.productid =  "\(tempModel.product_id)"
    
        self.navigationController?.pushViewController(detailVC, animated: true);
        
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
