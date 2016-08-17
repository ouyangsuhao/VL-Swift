//
//  HomeViewController.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/7/19.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit



class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var birdImageViewe: UIImageView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    //导航栏
    var navigationView : UIView!;
    
    //轮播图
    var cycleScrollView : SDCycleScrollView!
    //轮播图数据模型数组
    var ringArray : Array<RingModle>!;
    //零分区区头的数据
    var aroundScenicList : Array<HomeZeroHeaderModle>!;
    //第一分区区头的数据
    var choiceDestList : Array<HomeZeroHeaderModle>!;
    
    //数据源
    var dataArray : Array <HomeCellModle>!;
    
    //游学数组
    var studyArray : Array <HomeCellModle>!;
    //门票数组
    var tickeArray : Array <HomeCellModle>!;
    //邮轮数组
    var shipArray : Array <HomeCellModle>!;
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.translucent = true;
        self.navigationView.hidden = false;
        self.tabBarController?.tabBar.hidden = false;
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.translucent = false;
        self.navigationView.hidden = true;
//        self.tabBarController?.tabBar.hidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ringArray = [RingModle]();
        self.aroundScenicList = [HomeZeroHeaderModle]();
        self.choiceDestList = [HomeZeroHeaderModle]();
        self.studyArray = [HomeCellModle]();
        self.tickeArray = [HomeCellModle]();
        self.shipArray = [HomeCellModle]();
        self.dataArray = [HomeCellModle]();
        //添加轮播图
        self.addRingView();
        //小鸟飞
        self.birdFly();
        //导航栏
        self.diyNavigation();
        
        //注册区头
        self.myTableView.registerNib(UINib.init(nibName: "HomeZeroHeaderViewTableViewHeaderFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "zero");
        
        self.myTableView.registerNib(UINib.init(nibName: "HomeFirstHeaderViewTableViewHeaderFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "first");
        
        //请求轮播图数据
        self.reuqestRingData();
        //请求数据
        self.requestData();
    }
    func addRingView(){
        
        self.cycleScrollView = SDCycleScrollView.init(frame: CGRectMake(0, 0, KDeviceWidth, 200), imageNamesGroup: ["banner1.png"]);
        //格式格式 :
        //        { (参数列表) ->返回值类型 in
        //            语句组
        //        }
        self.cycleScrollView.clickItemOperationBlock = {(index:Int) in
            print(index);
        };
        //***************  还可以写成这个样子***********************//
        //        self.cycleScrollView.clickItemOperationBlock = test;
        
        //    func test(index : Int)->Void {
        //        print(index)
        //    }
        //******************************************************//
        
        
        self.myTableView.tableHeaderView!.addSubview(self.cycleScrollView);
    }
    
    func birdFly(){
        var arr = [UIImage]();
        for num in 1...11 {
            let imageName : String = String(format: "鸟的煽动动画%04d", num);
            let image  =  UIImage.init(named: imageName)!;
            arr.append(image);
        }
        
        self.birdImageViewe.animationImages = arr;
        self.birdImageViewe.animationDuration = 0.7;
        self.birdImageViewe.animationRepeatCount = 0;
        self.birdImageViewe.startAnimating();
    }
    
    func diyNavigation() -> Void {
        self.navigationView = UIView.init(frame: CGRectMake(0, 0, KDeviceWidth, 60));
        self.navigationView.userInteractionEnabled = true;
        self.navigationController?.navigationBar.addSubview(self.navigationView);
        self.navigationController?.navigationBar.bringSubviewToFront(self.navigationView);
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default;
        self.navigationController?.navigationBar.shadowImage = UIImage.init();

        let button : UIButton = UIButton.init(type: UIButtonType.Custom);
        button.frame = CGRectMake(0, 0, 80, 40);
        button.setTitle("城市", forState: UIControlState.Normal);
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal);
        button.addTarget(self, action: #selector(self.cityAction), forControlEvents: UIControlEvents.TouchUpInside);
        
        button.setImage(UIImage.init(named: "矩形-36"), forState: UIControlState.Normal);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        self.navigationView.addSubview(button);
        
        //输入框
        let searchTextField = UITextField.init(frame: CGRectMake(80, 5, KDeviceWidth - 80 - 40, 30));
        searchTextField.borderStyle = UITextBorderStyle.RoundedRect;
        searchTextField.layer.borderColor = UIColor.whiteColor().CGColor;
        searchTextField.layer.borderWidth = 1;
        searchTextField.backgroundColor = UIColor.init(colorLiteralRed: 239 / 255.0, green: 239 / 255.0, blue: 244 / 255.0, alpha: 0.5);
        searchTextField.placeholder = "景区/地区/关键字";
        let leftView : UIImageView = UIImageView.init(frame: CGRectMake(5, 0, 30, 15));
        leftView.image = UIImage.init(named: "Search");
        leftView.contentMode = UIViewContentMode.ScaleAspectFit;
        searchTextField.leftViewMode = UITextFieldViewMode.Always;
        searchTextField.leftView = leftView;
        searchTextField.layer.cornerRadius = 5;
        self.navigationView.addSubview(searchTextField);

        
        //二维码扫描
        let scanButton : UIButton = UIButton.init(type: UIButtonType.Custom);
        scanButton.frame = CGRectMake(KDeviceWidth - 40, 0, 40, 40);
        scanButton.setImage(UIImage.init(named: "扫一扫-副本"), forState: UIControlState.Normal);
        scanButton.addTarget(self, action: #selector(self.scanAction), forControlEvents: UIControlEvents.TouchUpInside);
        self.navigationView.addSubview(scanButton);
        
        //设置全透明的效果背景图
    
        self.navigationController?.navigationBar.setBackgroundImage(self.drawPngWithAlpha(0), forBarMetrics: UIBarMetrics.Default);
    }
    
    
    func cityAction() -> Void {
        let cityVC = CityListViewController()
        let navigation = UINavigationController.init(rootViewController: cityVC)
        presentViewController(navigation, animated: true, completion: nil)
    }
    func scanAction() -> Void {
        //二维码扫描方法
        print("二维码扫描");
    }
    
    
    func drawPngWithAlpha(alpha : Float) -> UIImage {
        let color : UIColor = UIColor.init(colorLiteralRed: 1, green: 1, blue: 1, alpha: alpha);
        //位图大小
        let size : CGSize = CGSizeMake(1, 1);
        //绘制位图
        UIGraphicsBeginImageContext(size);
        //获取当前创建的内容
        let contextRef = UIGraphicsGetCurrentContext();
        //充满指定的填充色
        CGContextSetFillColorWithColor(contextRef, color.CGColor);
        //充满指定的矩形
        CGContextFillRect(contextRef, CGRectMake(0, 0, 1, 1));
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext();
        //结束绘制
        UIGraphicsEndImageContext();
        return image;
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.myTableView {
            let ySet : CGFloat = scrollView.contentOffset.y;
            let alpha = ySet / 80  > 1.0 ? (1.0) : ySet / 80;
            self.navigationController?.navigationBar.setBackgroundImage(self.drawPngWithAlpha(Float(alpha)), forBarMetrics: UIBarMetrics.Default);
            if alpha == 1 {
                self.navigationController?.navigationBar.translucent = false;
            }else{
                self.navigationController?.navigationBar.translucent = true;
            }

        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func typeTap(sender: UITapGestureRecognizer) {
        let tagNum : Int = sender.view!.tag
        
        switch tagNum {
        case 1000:
            print("旅游度假");
            break
        case 1001:
            print("目的地参团");
            break
        case 1002:
            print("邮轮");
            let shipVC = ShipViewController.init();
            self.navigationController?.pushViewController(shipVC, animated: true);
            break
        case 1003:
            print("签证");
            break
        case 1004:
            print("游学");
            break
        case 1005:
            print("门票");
            break
            
        default:
            break
        }
        
        
    }
    //请求首页数据
    func requestData() -> Void {
        self.showProgressHUD();
        NewNetworkManage.requestGETWithRequest(KHomeDataUrl, dic: [], finshBlock: { (resObjcet) in
            print(resObjcet);
            self.hideProgressHUD();
            let status = resObjcet .objectForKey("status")?.intValue
            if (status == 1){
                //封装第零分区区头的数据
                let temAroundScenicList = resObjcet.objectForKey("data")?.objectForKey("aroundScenicList") as! NSArray;
                for dic in temAroundScenicList {
                    let mod = HomeZeroHeaderModle.init();
                    mod.setValuesForKeysWithDictionary(dic as! [String : AnyObject]);
                    mod.descriStr = dic .objectForKey("description") as! String;
                    self.aroundScenicList.append(mod);
                }
                //封装第一分区区头的数据
                let temchoiceDestList = resObjcet.objectForKey("data")?.objectForKey("choiceDestList") as! NSArray;
                for dic in temchoiceDestList {
                    let mod = HomeZeroHeaderModle.init();
                    mod.setValuesForKeysWithDictionary(dic as! [String : AnyObject]);
                    mod.descriStr = dic .objectForKey("description") as! String;
                    self.choiceDestList.append(mod);
                }
                
                //封装游学 门票 邮轮数组
                let productTabList = resObjcet.objectForKey("data")?.objectForKey("productTabList") as! NSArray;
                
                for dic in productTabList {
                    
                    let mess = dic.objectForKey("title") as! String;
                    let list = dic.objectForKey("list") as! NSArray;

                    switch mess {
                    case "邮轮":
                        for modDic in list {
                            let mod = HomeCellModle.init();
                            mod.setValuesForKeysWithDictionary(modDic as! [String : AnyObject]);
                            let thumb = modDic.objectForKey("thumb") as! String;
                            mod.headImageUrlStr = KImageIndexUrl+thumb;
                            let  str = modDic.objectForKey("port_name") as!String;
                            
                            mod.addressStr = "[\(str)出发]";
                            mod.priceCountStr = "￥" + (modDic.objectForKey("min_price") as! String);
                            mod.titDetailStr = (modDic.objectForKey("product_name")as! String)
                            
                            self.shipArray.append(mod);
                        }
                        
                        break;
                        
                    case "门票":
                        for modDic in list {
                            let mod = HomeCellModle.init();
                            mod.setValuesForKeysWithDictionary(modDic as! [String : AnyObject]);
                            let temimage = modDic.objectForKey("images")?.objectForKey("image");
                                
                            if (temimage?.isKindOfClass(NSArray) == true) {
                                
                                mod.headImageUrlStr = (temimage as! NSArray).firstObject as! String;

                            }else{
                                mod.headImageUrlStr = temimage as! String;
                            }
                            
                            mod.titDetailStr = modDic.objectForKey("product_name") as! String;
                            
                            let place_level = modDic.objectForKey("place_level");
                            if place_level?.isEqual("") == true {
                            
                                let product_theme = modDic.objectForKey("product_theme");
                                if product_theme?.isEqual("") == true {
                                    mod.addressStr = "";
                                }else{
                                    mod.addressStr = modDic.objectForKey("product_theme") as! String;
                                }
                                
                            }else{
                                mod.addressStr = "景区级别:" + (modDic.objectForKey("place_level") as! String);
                                
                            }
                            mod.priceCountStr = "￥" + (modDic.objectForKey("start_price") as! String);
                            
                            self.tickeArray.append(mod);

                            
                        }
                        break;
                    case "游学":
                        for modDic in list {
                            let mod = HomeCellModle.init();
                            mod.setValuesForKeysWithDictionary(modDic as! [String : AnyObject]);
                            mod.product_id = modDic.objectForKey("id") as! String;
                            mod.headImageUrlStr = KImageIndexUrl + (modDic.objectForKey("thumb") as! String);
                            mod.titDetailStr = modDic.objectForKey("name") as!String;
                            
                            mod.addressStr = modDic.objectForKey("setoff_date") as!String;
                            mod.priceCountStr =  "￥" + (modDic.objectForKey("camper_price") as!String);
                            self.studyArray.append(mod);

                        }
                        break;
                    default:
                        break
                   
                    }
                }
            }
            self.dataArray = self.shipArray;
            self.myTableView.reloadData();
        }) { (conError) in
            self.hideProgressHUD();
            print(conError);
        }
    }
    
    //请求轮播图数据
    func reuqestRingData(){
        self.showProgressHUD()
        NewNetworkManage.requestGETWithRequest(KHomeRingUrl, dic: [], finshBlock: { (resObjcet) in
            self.hideProgressHUD();
            
            let temArr = resObjcet as! NSArray;
            var imagUrlArr = [String]();
            for dic in temArr{
                let mod : RingModle = RingModle.init();
                mod.setValuesForKeysWithDictionary(dic as! [String : AnyObject]);
                imagUrlArr.append(KImageIndexUrl + ((dic.objectForKey("src")) as! String));
                self.ringArray.append(mod);
            }
            self.cycleScrollView.imageURLStringsGroup = imagUrlArr;
            
            
        }) { (conError) in
            self.hideProgressHUD();
            print(conError);
        }
    };
    
    
    //MARK UITableViewDelegate, UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 420;
        default:
            return 270;
        }
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let  headerView : HomeZeroHeaderViewTableViewHeaderFooterView =   tableView.dequeueReusableHeaderFooterViewWithIdentifier("zero") as! HomeZeroHeaderViewTableViewHeaderFooterView;
            headerView.showDataWithMod(self.aroundScenicList);
            
            headerView.moreBlock = {()in
                print("点击了更多");
            };
            
            headerView.typeBlock = {(selNum : Int) in
                print(selNum);
            };
            
            headerView.footerBlock = {() in
                print("脚部");
            };
            return headerView;
            
        default:
            let headerView : HomeFirstHeaderViewTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("first") as! HomeFirstHeaderViewTableViewHeaderFooterView;
            headerView.showDataWithMod(self.choiceDestList);
            
            //点击门票和游学 邮轮的回调
            headerView.typeBlock = {(indexType : Int) in
                print(indexType);
                switch indexType {
                case 0:
                    self.dataArray = self.shipArray;
                    self.myTableView.reloadData();
                    break;
                case 1:
                    self.dataArray = self.studyArray;
                    self.myTableView.reloadData();
                    break
                    
                default:
                    self.dataArray = self.tickeArray;
                    self.myTableView.reloadData();
                    break;
                }
            };
            
            return headerView;
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section {
        case 0:
            return 0;
        default:
            return self.dataArray.count;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HomeTableViewCell;
        let mod = self.dataArray[indexPath.row];
        cell.showDataWithModle(mod);
        return cell;
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
