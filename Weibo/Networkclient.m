//
//  Networkclient.m
//  Weibo
//
//  Created by 陶怡然 on 15/3/23.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "Networkclient.h"


@implementation Networkclient

static Networkclient *networkclient = nil;

+ (Networkclient *)sharedInstance
{
    if (nil == networkclient)
    {
        networkclient = [[Networkclient alloc] init];
        //        netclient.nextUrlString = nil;
    }
    return networkclient;
}


- (void) getweibodata:(void (^)(NSDictionary *data)) completionBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json?access_token=2.009TujxF0UDa7idb088651a2ndcTeE" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *data) {
        NSLog(@"JSON: %@", data);
        completionBlock(data);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failureBlock(error);
        
    }];
}


@end
