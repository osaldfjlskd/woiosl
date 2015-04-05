//
//  WeiboCell.h
//  Weibo
//
//  Created by hellovoidworld on 14/12/5.
//  Copyright (c) 2014年 hellovoidworld. All rights reserved.
//

// 用于装载每个TabelViewCell的model
#import <UIKit/UIKit.h>

@class WeiboFrame;
@interface WeiboCell : UITableViewCell<UIScrollViewDelegate>

// 微博frame，内持有微博数据和尺寸、位置信息
@property(nonatomic, strong) WeiboFrame *weiboFrame;
@property (nonatomic, strong) NSDictionary *weibodata;
@property (nonatomic, strong) NSArray *picArray;

@property(nonatomic, weak) IBOutlet UIImageView *iconView;

/** 昵称 */
@property(nonatomic, weak) IBOutlet UILabel *nameView;


@property (weak, nonatomic) IBOutlet UILabel *timephoneLable;

/** vip标志 */
@property(nonatomic, weak) IBOutlet UIImageView *vipView;

/** 博文 */
@property(nonatomic, weak) IBOutlet UILabel *textView;

/** 配图 */
@property(nonatomic, weak) IBOutlet UIImageView *pictureView;
//点赞
@property (retain, nonatomic) IBOutlet UILabel *countLB;
@property (retain, nonatomic) IBOutlet UILabel *timeLB;
@property (retain, nonatomic) IBOutlet UILabel *fromLB;



@property (retain, nonatomic) IBOutlet UILabel *zhuanfaLable;
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
@property (weak, nonatomic) IBOutlet UILabel *zanLable;

//UIPageControl *pageControl
@property(nonatomic, weak) UIPageControl *pageControl;

// 自定义带有父控件tableView初始化方法
+ (instancetype) cellWithTableView:(UITableView *) tableView ;
- (void)setbasic:(NSDictionary *)theweibodata;
@end
