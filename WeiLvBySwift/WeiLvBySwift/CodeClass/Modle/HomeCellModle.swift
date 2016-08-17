//
//  HomeCellModle.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/1.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class HomeCellModle: BaseModle {
    var admin_id : String = "";
    var album : String = "";
    var brand_name : String = "";
    var line_name : String = "";
    var port_name : String = "";
    var product_id : String = "";
    var sell_count : String = "";
    var setoff_date : String = "";
    var ship_name : String = "";
    var thumb : String = "";
    var product_name : String = "";
    
    
    //门票
    var bookingInfo : Dictionary<String,String> = [:];
    var images : NSMutableDictionary = NSMutableDictionary();
    var is_hot : String = "";
    var is_recommend : String = "";
    var openTime : String = "";
    var place_city : String = "";
    var place_country : String = "";
    var place_id : String = "";
    var place_level : String = "";
    var place_province : String = "";
    var placeTo_addr : String = "";
    var playAttraction = NSMutableArray();
    var product_reminder : String = "";
    var product_theme : String = "";
    var scenic_attach : NSMutableDictionary = NSMutableDictionary();
    var scenic_name : String = "";
    var service_guarantee : String = "";
    var start_price : String = "";
    var updata_time : String = "";
//游学
    var camper_price : String = "";
    var camper_rebate : String = "";
    var is_assistant : String = "";
    var name : String = "";
    var headImageUrlStr : String = "";
    var titDetailStr : String = "";
    var priceCountStr : String = "";
    var addressStr : String = "";
    
}
