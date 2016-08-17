//
//  CityListViewController.swift
//  WeiLvBySwift
//
//  Created by Aurora on 16/8/3.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CityListCell"

class CityListViewController: UICollectionViewController {
    var dataDic = NSMutableDictionary()
    var keysArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//背景图片
        self.view.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "city_backImage.png")!);
        //  调用数据请求的方法
        self.requestData()
   
//注册cell
        self.collectionView!.registerNib(UINib.init(nibName: "CityListCollectionCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "city_backImage.png")!);
//注册区头
       self.collectionView?.registerNib(UINib.init(nibName: "HeaderSectionView", bundle: NSBundle.mainBundle()), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")

        self.returnLastViewAction()
        self.navigationItem.title = "选择城市"
    
    }
    
    
//MARK:--网络请求
    func requestData() {
        NewNetworkManage.requestGETWithRequest(kCityListUrl, dic:[] , finshBlock: { (resObjcet) in
            //解析数据
            self.handleDataWithObject(resObjcet as! NSDictionary)
            }) { (conError) in
                
        }
    }
    //MARK:读取plist文件数据.获取热门城市和快速定位
    func getHotCityByPlist() {
    let array = NSArray.init(contentsOfFile: NSBundle.mainBundle().pathForResource("HotCityList", ofType: "plist")!)
        let hotKey:String = "热门城市"
        let positionKey = "快速定位"
        self.keysArray.insertObject("当前定位城市", atIndex: 0)
        self.keysArray.insertObject(hotKey, atIndex: 1)
        self.keysArray.insertObject(positionKey, atIndex: 2)
        
        self.dataDic.setObject(array!, forKey: hotKey)
    }
    
    //MARK:--数据解析
    func handleDataWithObject(resObject:NSDictionary) {
     let   listArray = resObject.objectForKey("data")
        let modelArray = NSMutableArray()
        for dic in listArray as! NSArray{
            if dic.objectForKey("region_type")?.isEqualToString("3") != false  {
                if dic.objectForKey("is_open") != nil {
               let    tempModel = CityListModel()
                    tempModel.setValuesForKeysWithDictionary(dic as! Dictionary)
                    modelArray.addObject(tempModel)
                }
            }
        }
        //遍历数组
            for tempModel in modelArray {
                
            var cityArray =  self.dataDic.objectForKey((tempModel as! CityListModel).prefix)
                if cityArray == nil {
                    cityArray = NSMutableArray()
                    self.dataDic .setObject(cityArray!, forKey: (tempModel as! CityListModel).prefix)
                    self.keysArray.addObject((tempModel as! CityListModel).prefix)
                }
                cityArray?.addObject(tempModel)
            
    }
       //升序
        self.dataDic.removeObjectForKey(self.keysArray.lastObject!)
   self.keysArray.removeLastObject()
        self.keysArray.sortUsingSelector(#selector(NSString.compare(_:)))
        //将快速定位的键值插入
        let  positionArray = NSArray.init(array: self.keysArray);
        self.dataDic.setObject(positionArray, forKey: "快速定位")
        //获取前三个分区的数据
        self.getHotCityByPlist()
//    print(self.dataDic)
        //重新加载
        self.collectionView?.reloadData()
        
        
    }
    
    init(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.headerReferenceSize = CGSizeMake(KDeviceWidth, 40)
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:导航控制器返回按钮
    func returnLastViewAction() {
     let leftButton = UIButton.init(type: .Custom)
        leftButton.setTitle("返回", forState: .Normal)
        leftButton.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        leftButton.frame = CGRectMake(0, 0, 50, 40)
        leftButton.addTarget(self, action: #selector(CityListViewController.returnAction), forControlEvents: .TouchUpInside)
        let leftButtonItem = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftButtonItem
    }
    
    func returnAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.keysArray.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
        return  (self.dataDic.objectForKey(self.keysArray.objectAtIndex(section))?.count)!
        }
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CityListCollectionCell
        if indexPath.section == 0 {
            cell.nameLabel.frame = CGRectMake(0, 0, KDeviceWidth, 30)
            cell.nameLabel.textAlignment = .Left
            return cell
            
                   }
         cell.nameLabel.frame = CGRectMake(0, 0, (KDeviceWidth - 8) / 5, 30)
        cell.nameLabel.textAlignment = .Center
      
        if indexPath.section == 0 {
            cell.nameLabel.frame = CGRectMake(0, 0, KDeviceWidth, 30)
            cell.nameLabel.textAlignment = .Left
            if PositionManager.sharedPositionManager().isCan == false {
                PositionManager.sharedPositionManager().locationBlock = {
                    (address:String) in
                    cell.nameLabel.text = address
                }
            }else {
                cell.nameLabel.text = "无法获取您的位置"
            }
            return cell
        }
        
        
        
        if indexPath.section == 1 {

         let str = self.dataDic.objectForKey("热门城市") as! NSArray
            cell.nameLabel.text = str.objectAtIndex(indexPath.row) as? String
            return cell

        }
        if indexPath.section == 2 {
            let str = self.dataDic.objectForKey("快速定位") as! NSArray
            cell.nameLabel.text = str.objectAtIndex(indexPath.row) as? String
            return cell
        }
        
        let  array = self.dataDic.objectForKey(self.keysArray.objectAtIndex(indexPath.section))
        print(array)
        let  tempModel = array?.objectAtIndex(indexPath.row) as! CityListModel
        cell.nameLabel.text = tempModel.region_name

        return cell
    }

 override   func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//    if kind == UICollectionElementKindSectionHeader {
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as! HeaderSectionView
        view.titleLabel.text = self.keysArray.objectAtIndex(indexPath.section) as? String
       return view
//    }
//        return nil
    
    }
    //MARK:--cell的点击事件.并且让视图滚动到指定位置
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if  indexPath.section == 2 {
            let tempIndexPath = NSIndexPath.init(forRow: 0, inSection: indexPath.row  + 3)
            self.collectionView?.scrollToItemAtIndexPath(tempIndexPath, atScrollPosition: .Top, animated: true)
            var  currentPoint = self.collectionView?.contentOffset
            currentPoint = CGPointMake(currentPoint!.x, currentPoint!.y - 25)
            self.collectionView?.contentOffset = currentPoint!
        }
    }
    //MARK:--设置item的大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if(indexPath.section == 0 && indexPath.row == 0) {
            return CGSizeMake(KDeviceWidth, 30)
        }
        return CGSizeMake((KDeviceWidth - 8 ) / 5, 30)
        
      
    }
    
    
    
    
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
