//
//  Networkclient.h
//  Weibo
//
//  Created by 陶怡然 on 15/3/23.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "global.h"
#import "AFHTTPRequestOperationManager.h"

typedef void (^BasicBlock)(NSDictionary *data);
typedef void (^FailureBlock)(NSError *error);

@interface Networkclient : NSObject

+ (Networkclient *)sharedInstance;

- (void) getweibodata:(BasicBlock)completionBlock failureBlock:(FailureBlock)failureBlock;

@end
