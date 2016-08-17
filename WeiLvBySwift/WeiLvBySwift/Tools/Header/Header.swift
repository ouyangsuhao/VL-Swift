//
//  Header.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/7/19.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

let KDeviceWidth = UIScreen .mainScreen().bounds.size.width

let KDeviceHeight = UIScreen .mainScreen().bounds.size.height

//后台接口

//请求首页周边景点、精选旅游目的地、邮轮、门票、游学数据
let KHomeCellUrl = "https://www.weilv100.com/api/appHome/getHomeInfo"
//图片地址前缀接口地址
let KImageIndexUrl = "https://www.weilv100.com"
//首页轮播图数据请求地址
let KHomeRingUrl = "https://www.weilv100.com/api/ad/ad_img_show/75/149"
//首页数据接口地址
let KHomeDataUrl = "https://www.weilv100.com/api/appHome/getHomeInfo?city_id=149&assistant=0"
//首页公告数据接口地址
let KNoticeUrl = "https://www.weilv100.com/api/appHome/getWeilvAnnounce"
//邮轮一级界面数据接口地址
let KShipUrl = "https://www.weilv100.com/api/cruise/index"
//城市列表接口
let kCityListUrl = "http://www.weilv100.com/api/route/region"


//邮轮界面接口地址
let KShipDataURL = "http://www.weilv100.com/api/cruise/index"
//邮轮详情界面地址
let KShipDetailURL = "https://www.weilv100.com/api/cruise/product/"



//邮轮二级详情界面数据接口
let KShipDetailUrl = "https://www.weilv100.com/api/cruise/product/"

//管家一级界面接口
let KStewardUrl = "https://www.weilv100.com/api/assistant/lists"

//登录接口
let KLoginUrl = "https://www.weilv100.com/api/member/login_action"
//请求订单列表地址
let KOrderListUrl = "https://www.weilv100.com/api/orderApi/getFrontList"

//请求订单详情
let  KOrderDetailUrl = "https://www.weilv100.com/api/orderApi/getOrderInfo"
//提交订单
let KUpDataOrderInfoUrl = "https://www.weilv100.com /api/orderApi/postOrder"

