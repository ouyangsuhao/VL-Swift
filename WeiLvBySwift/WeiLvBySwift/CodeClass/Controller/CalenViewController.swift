//
//  CalenViewController.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/3.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class CalenViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "邮轮日历";
        self.view.backgroundColor = UIColor.yellowColor()
        
        let calender : CalenderView = CalenderView.createCalenderView();
        calender.frame = self.view.bounds;
        self.view.addSubview(calender);

        calender.showSignWithArray(["2016-5-19","2016-6-21","2016-5-20"]);
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
