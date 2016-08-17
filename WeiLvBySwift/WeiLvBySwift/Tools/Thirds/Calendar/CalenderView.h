//
//  CalenderView.h
//  日历相关
//
//  Created by 孙云 on 16/4/12.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderView : UIView<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSDate *date;
//日历表的数据源
@property(nonatomic,strong)NSMutableArray *dateArray;
//标记数据源
@property(nonatomic,strong)NSArray *signArray;

// 月份显示
@property (weak, nonatomic) IBOutlet UILabel *showDateLabel;
//时间显示
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//事件显示
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//前一个月
- (IBAction)clickPreBtn:(id)sender;
//后一个月
- (IBAction)clickNextBtn:(id)sender;
+ (instancetype)createCalenderView;

//显示标记方法
- (void)showSignWithArray:(NSArray *)array;


@end
