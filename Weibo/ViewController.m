//
//  ViewController.m
//  Weibo
//
//  Created by hellovoidworld on 14/12/4.
//  Copyright (c) 2014年 hellovoidworld. All rights reserved.
//

#import "ViewController.h"
#import "Weibo.h"
#import "WeiboCell.h"
#import "WeiboFrame.h"
#import "AFHTTPRequestOperationManager.h"
#import "global.h"
#import "Networkclient.h"

@interface ViewController ()

/** 微博数组，类型是WeiboFrame，包含了数据和位置尺寸信息 */
@property(nonatomic, strong) NSArray *weibos;
@property(nonatomic, strong) NSArray *weiboframe;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json?access_token=2.009TujxF0UDa7idb088651a2ndcTeE" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
//    if (statuesArr != nil && statuesArr.count != 0) {
//        return;
//    }
    NSString *authToken = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_ACCESS_TOKEN];
    if (authToken == nil)
    {

        [[Networkclient sharedInstance] getweibodata:^(NSDictionary *data) {
            NSLog(@"JSON: %@", data);
            
            NSArray *dictArray =[data objectForKey:@"statuses"];
            
            for (NSDictionary *dict in dictArray) {
                WeiboFrame *weiboFrame = [[WeiboFrame alloc] init];
                
            }
            
            _weibos = dictArray;
            [self.tableView reloadData];
        } failureBlock:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
//        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//        request.redirectURI = @"https://api.weibo.com/oauth2/default.html";
//        request.scope = @"all";
//        request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
//                             @"Other_Info_1": [NSNumber numberWithInt:123],
//                             @"Other_Info_2": @[@"obj1", @"obj2"],
//                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//
//        [WeiboSDK sendRequest:request];
    }
    else
    {
//        [self getDataFromCD];
//        
//        if (!statuesArr || statuesArr.count == 0) {
//            [manager getHomeLine:-1 maxID:-1 count:-1 page:-1 baseApp:-1 feature:-1];
//            [[SHKActivityIndicator currentIndicator] displayActivity:@"正在载入..." inView:self.view];
//        }
//        
//        [manager getUserID];
//        [manager getHOtTrendsDaily];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 屏蔽状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark -  数据源操作
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.weibos.count;
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 传入tableView是为了使用cell缓存池
    WeiboCell *cell = [WeiboCell cellWithTableView:self.tableView];
    
    // 传入微博的数据和位置尺寸信息
    cell.weibodata = self.weibos[indexPath.row];
    cell.weiboFrame = self.weiboframe[indexPath.row];
    NSLog(@"%ld",(long)indexPath.row);
    return cell;
}


#pragma mark - 加载数据
// 延迟加载plist文件中的数据为微博数组
- (NSArray *) weibos {
    if (nil == _weibos) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weibo.plist" ofType:nil]];
        
        NSMutableArray *mdictArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            WeiboFrame *weiboFrame = [[WeiboFrame alloc] init];
            Weibo *weibo = [Weibo weiboWithDictionary:dict];
            
            // 传入weibo模型数据到frame模型，内部保存数据，计算各个控件的位置、尺寸
            weiboFrame.weibo = weibo;
            
            [mdictArray addObject:weiboFrame];
        }
        
        _weiboframe = mdictArray;
    }
    
//
//        [[Networkclient sharedInstance] getweibodata:^(NSDictionary *data) {
//            NSLog(@"JSON: %@", data);
//            
//            NSArray *dictArray =[data objectForKey:@"statuses"];
//
//            for (NSDictionary *dict in dictArray) {
//                WeiboFrame *weiboFrame = [[WeiboFrame alloc] init];
//
//            }
//            
//            _weibos = dictArray;
//            [self.tableView reloadData];
//        } failureBlock:^(NSError *error) {
//            NSLog(@"Error: %@", error);
//        }];
    

    
    return _weibos;
}


#pragma mark - 代理操作
// 动态调整每个cell的高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboFrame *weiboFrame = self.weibos[indexPath.row];
//    if (weiboFrame == nil) {
        return 300.0;
//    }
//    return weiboFrame.cellHeight;
}

@end
