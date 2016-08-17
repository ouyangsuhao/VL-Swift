//
//  NewNetworkManage.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/7/22.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class NewNetworkManage: NSObject {

    
    class func requestGETWithRequest(urlStr:NSString, dic:AnyObject?, finshBlock:((resObjcet : AnyObject)->Void)!, failBlock:((conError:NSError)->Void)!)->Void{
        let manager : AFHTTPSessionManager = AFHTTPSessionManager.init();
        manager.responseSerializer.acceptableContentTypes = NSSet.init(objects: "text/html", "application/json") as? Set<String>;
        manager.GET(urlStr as String, parameters: dic, progress: { (progres : NSProgress) in
            }, success: { (task:NSURLSessionDataTask, resObjet: AnyObject?) in
                finshBlock(resObjcet: resObjet!);
        }) { (task : NSURLSessionDataTask?, error: NSError) in
            failBlock(conError: error);
        };
        
    }
    
    class func requestPOSTWithRequest(urlStr:NSString, dic:AnyObject, finshBlock:((resObjcet : AnyObject)->Void)!, failBlock:((conError:NSError)->Void)!)->Void{
        let manager : AFHTTPSessionManager = AFHTTPSessionManager.init();
        manager.responseSerializer.acceptableContentTypes = NSSet.init(objects: "text/html", "application/json") as? Set<String>;
        
        manager.POST(urlStr as String, parameters: dic, progress: { (progress: NSProgress) in
            
            }, success: { (task : NSURLSessionDataTask, resObjcet : AnyObject?) in
                finshBlock(resObjcet: resObjcet!);

        }) { (task : NSURLSessionDataTask?, eror: NSError) in
            failBlock(conError: eror);
        }
    }
}
