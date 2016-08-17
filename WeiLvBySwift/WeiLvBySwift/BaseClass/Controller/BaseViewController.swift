//
//  BaseViewController.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/7/19.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    

    lazy var progressHUD : MBProgressHUD = {
        let  pro : MBProgressHUD  = MBProgressHUD.init(view: self.view);
        self.view.addSubview(pro);
        return pro;
    }();
    
    func showProgressHUD() -> Void {
        self.showProgressHUDWithStr("");
    }
    
    func showProgressHUDWithStr(tit:String) -> Void {
        if (tit == "") {
            self.progressHUD.labelText = nil;
        }else{
            self.progressHUD.labelText = tit;
        }
        //显示loading方法
        self.progressHUD.show(true);
    }
    
    func hideProgressHUD() -> Void {
        self.progressHUD.hide(true);
    }
    
//    ///隐藏loading
//    - (void)hideProgressHUD
//    {
//    if (self.progressHUD != nil) {
//    [self.progressHUD hide:YES];
//    [self.progressHUD removeFromSuperViewOnHide];
//    self.progressHUD = nil;
//    }
//    }
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
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
