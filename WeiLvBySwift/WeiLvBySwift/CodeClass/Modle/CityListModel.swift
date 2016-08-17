//
//  CityListModel.swift
//  WeiLvBySwift
//
//  Created by Aurora on 16/8/3.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class CityListModel: NSObject {
//城市是否开放
    var is_open:String!
    //id
    var parent_id:String!
    //首字母大写
    var  prefix:String!
    //拼音
    var py:String!
    //地区的ID
    var  region_id:String!
    //地区名字
    var region_name:String!
    //地区类型
    var region_type:String!
  
    //KVC键值编码异常方法
  override  func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
