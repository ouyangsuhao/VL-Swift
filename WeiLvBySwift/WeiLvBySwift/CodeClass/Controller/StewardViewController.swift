//
//  StewardViewController.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/7/19.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class StewardViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var page : Int!
    
    var dataArray : Array<StewardCellModle>!
    
    var allSexVC : AllSexViewController!
    //轮播图
    var cycleScrollView : SDCycleScrollView!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.page = 0;
        self.dataArray = [StewardCellModle]();
        
        self.myTableView.registerNib(UINib.init(nibName: "StewardHeaderViewHeaderFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "header")
        
        self.allSexVC = AllSexViewController.init();
        self.allSexVC.view.frame = CGRectMake(0, 280, KDeviceWidth, KDeviceHeight);
        self.view.addSubview(self.allSexVC.view);
        self.addChildViewController(self.allSexVC);
        self.view.bringSubviewToFront(self.allSexVC.view);
        self.allSexVC.view.hidden = true;
        
        self.addRingView();
        self.requestData();
        
        
        //添加上拉刷新 下拉加载的功能
        self.myTableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page = self.page + 10;
            self.requestData();
        })
            
            
        self.myTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { 
            self.page = 0;
            self.requestData();
        })
    }

    func addRingView() -> Void {
        self.cycleScrollView = SDCycleScrollView.init(frame: CGRectMake(0, 0, KDeviceWidth, 180), imageNamesGroup: ["home_assisant_ad"]);
        self.cycleScrollView.clickItemOperationBlock = {(index:Int) in
            print(index);
        };
        
        self.myTableView.tableHeaderView!.addSubview(self.cycleScrollView);

    }
    
    func requestData() -> Void {
        self.showProgressHUD();
       NewNetworkManage.requestGETWithRequest(KStewardUrl, dic: ["limit":"10", "offset":self.page,"region_id":"149"], finshBlock: { (resObjcet) in
        self.hideProgressHUD();
        self.myTableView.mj_header.endRefreshing();
        self.myTableView.mj_footer.endRefreshing();

        if resObjcet .objectForKey("status")?.intValue == 1 {
            
            if self.page == 0 {
                self.dataArray.removeAll();
            }
            
            let temArr = resObjcet.objectForKey("data") as! NSArray;
            
            for dic in temArr {
                let mod : StewardCellModle = StewardCellModle.init();
                mod.setValuesForKeysWithDictionary(dic as! [String : AnyObject]);
                self.dataArray.append(mod);
            }
            self.myTableView.reloadData();
        }
        
        
        }) { (conError) in
            self.hideProgressHUD();

            self.myTableView.mj_header.endRefreshing();
        
            self.myTableView.mj_footer.endRefreshing();
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.myTableView.scrollEnabled = true;
        self.allSexVC.view.hidden = true;
    }
    
    //MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("header") as! StewardHeaderViewHeaderFooterView;
        
        headerView.selBlock = {(tit : String) in
            switch tit {
            case "案例":
                
                print("案例");
                break
            case "评分":
                
                print("评分");
                break
                
            default:
                print("全部");
                self.myTableView.scrollEnabled = false;
                self.allSexVC.view.hidden = false;
                break
            }
        };
        
        return headerView;
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.myTableView {
            if scrollView.contentOffset.y >= 170 {
                self.allSexVC.view.frame = CGRectMake(0, 50, KDeviceHeight, 0)
                UIView.animateWithDuration(0.5, animations: {
                    self.allSexVC.view.frame =  CGRectMake(0, 90, KDeviceHeight, KDeviceHeight)
                    
                })

            }else {
                self.allSexVC.view.frame =  CGRectMake(0, 240 - scrollView.contentOffset.y + 40, KDeviceHeight, 0)
                UIView.animateWithDuration(0.5, animations: {
                    self.allSexVC.view.frame =  CGRectMake(0, 240 - scrollView.contentOffset.y + 40, KDeviceHeight, KDeviceHeight)
                    
                })

            }
            
            
            
            
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! StewardTableViewCell;
        cell.showData(self.dataArray[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100;
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
