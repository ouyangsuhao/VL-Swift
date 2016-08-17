//
//  PositionManager.swift
//  WeiLvBySwift
//
//  Created by Aurora on 16/8/4.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit
import CoreLocation

class PositionManager: NSObject, CLLocationManagerDelegate {
    var locationBlock:((String)->Void)!
    var  address:String!
    var coordinate:CLLocationCoordinate2D!
    //是否可以定位
    var isCan:Bool!
    //  负责定位的管理对象
    var   locationManager:CLLocationManager!
    //负责地理编码的对象
    var geocoder:CLGeocoder!
    class func sharedPositionManager() ->PositionManager {
        struct myManager {
            static var  manager:PositionManager!
            static var onceToken:dispatch_once_t = 1
        }
        dispatch_once(&myManager.onceToken) {
            myManager.manager = PositionManager()
            myManager.manager.geocoder = CLGeocoder()
        }
        return myManager.manager
    }
    
    //开启定位的方法
    func startPositionYourLocation() {
        self.locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() == false {
        print("手中定位服务没有开启")
            let  url = NSURL.init(string: UIApplicationOpenSettingsURLString)
       UIApplication.sharedApplication().openURL(url!)
        self.isCan = false
            return
        }
        
//        if ( CLLocationManager.authorizationStatus) == kcl{
    self.locationManager.requestWhenInUseAuthorization()
//        }
        //开始定位
        self.isCan = true
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self;
        self.locationManager.startUpdatingLocation()
    }
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let coordinate = location!.coordinate
        //调用地理编码将经纬度变为确定的位置信息
        self.getChineseAddressByCoordinate(coordinate)
    }
    
    func getChineseAddressByCoordinate(coordinate:CLLocationCoordinate2D) {
        let location = CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
        //反地理编码
        self.geocoder .reverseGeocodeLocation(location) { (placemarks, error) in
            let placemark = placemarks?.first
            let dicAddress = placemark!.addressDictionary
            
            self.address = dicAddress!["City"] as! String
            if self.address != nil {
    self.locationBlock(self.address)
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    
    
    
    
    
}
