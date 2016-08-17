//
//  AllSexViewController.swift
//  WeiLvBySwift
//
//  Created by tiger on 16/8/3.
//  Copyright © 2016年 韩山虎. All rights reserved.
//

import UIKit

class AllSexViewController: BaseViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTableView: UITableView!

    var dataArray : Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(colorLiteralRed: 174/255.0, green: 174/255.0, blue: 174/255.0, alpha: 0.3);
        self.dataArray = [String]();
        
        self.dataArray.append("男");
        self.dataArray.append("女");
        self.dataArray.append("全部");
        
        self.myTableView.scrollEnabled = false;
        
        self.myTableView.reloadData();
        self.myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");
        
        
        
        // Do any additional setup after loading the view.
    }
    //MARK : UITableViewDelegate, UITableViewDataSource
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath);
        cell.textLabel?.text = self.dataArray[indexPath.row];
        return cell;
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
